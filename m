From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with 
	test_must_fail
Date: Tue, 20 Jul 2010 23:44:23 +0000
Message-ID: <AANLkTilzC8iMikfBieS_pcChP7_F4hA6bT1ydWHD4etP@mail.gmail.com>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
	<iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, erick.mattos@gmail.com, jrnieder@gmail.com,
	jaredhance@gmail.com, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jul 21 01:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObMUB-0001pe-Gn
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 01:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933016Ab0GTXo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 19:44:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63969 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853Ab0GTXoZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 19:44:25 -0400
Received: by fxm14 with SMTP id 14so3201502fxm.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 16:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9DP0fhlpG9A+ZmQmjBBwVDvh+XGYTQmhXWoxLJN7zgE=;
        b=ob9l0BgbTPRGGAfwRT/9SVsDizWtO4/aKpN2KUfpxQNb1YnoxivpIFE9dN47CWsMSw
         T12K6eO0zpTEqw3plzWKTq3aD12EpxHsFbJiizLSXpn99MhXQJicKU3Bu0lY8RN6M8zW
         iu0g75rEEHyS13wNF7H4Sc2CAevV81GlufnZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KosXhktKf6OEV50/TTZLuy/wLgehyANerd6euTWRdnq4OxjrUML6ZgLLkM17q1Cbx3
         WJwZg9iSv13LFbWRF3Jy/YCKa/blZX6Y9+VCq7sCa+j1g41pqtxKQUgyVyUzbvKwhkqr
         wkZtyMULP74ww4QWwQQigS2DExX8V505viJtM=
Received: by 10.223.112.10 with SMTP id u10mr1586394fap.50.1279669463951; Tue, 
	20 Jul 2010 16:44:23 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Tue, 20 Jul 2010 16:44:23 -0700 (PDT)
In-Reply-To: <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151376>

On Tue, Jul 20, 2010 at 21:55, Brandon Casey <casey@nrlssc.navy.mil> wr=
ote:

> - =C2=A0 =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show delta =
&&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGER=3D &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export PAGER &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 reflog show delta
> + =C2=A0 =C2=A0 =C2=A0 ) &&

You must use "export PAGER;", not "export PAGER &&". export doesn't
return zero on all systems when exporting, see previous changes in
this regard in t/.
