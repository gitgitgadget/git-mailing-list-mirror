From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCHv2] repack: rewrite the shell script in C.
Date: Sun, 18 Aug 2013 16:34:31 +0200
Message-ID: <5210DB77.3090004@googlemail.com>
References: <7v8v02swnc.fsf@alter.siamese.dyndns.org> <1376611978-13189-1-git-send-email-stefanbeller@googlemail.com> <520F7BDE.9090902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 18 16:34:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB43w-00089t-CR
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 16:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475Ab3HROeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Aug 2013 10:34:31 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:58751 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab3HROea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 10:34:30 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so1687276eek.26
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5O+Tu1zeBe3/g1t34/s01fl+dozDvhVnX2ZV8luYTv0=;
        b=LgGaodtrQWc5eF1bnLS6yF8TNTYmIVERUPjYvEs0Lc8Q/+gkulHlBAgF7qvBCxo518
         6U0FQN/fh6xe27iXR7J/6YdtzOCSsjQO39x4YUqDSlmpQ5v+2hwWBlBk1zMqULuWJFLM
         g3pySfFPuC9i8+8lijd2rsiOAjH8tHkpFR6JsntN70RDwGse/7qJJswza+gVssNg7SsN
         RqMMJ9/wY6kS94SGkPdg6bCzmzEkRzIWatTuHxfHa+FwrG1uWsHlOzRaPBRLb7OyVFzR
         QeP/n/aRPVp8Hy3OjKy5h2vu83aVb2xMZjVRJWtEKjUNcBrk5LclpdcZ6Rzbn613dMF/
         BCBw==
X-Received: by 10.14.241.74 with SMTP id f50mr14908372eer.29.1376836469452;
        Sun, 18 Aug 2013 07:34:29 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id z12sm10670527eev.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 07:34:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <520F7BDE.9090902@web.de>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232477>

On 08/17/2013 03:34 PM, Ren=E9 Scharfe wrote:
>=20
> Hmm, stepping back a bit, why not just build the paths and call unlin=
k
> for them right away, without readdir?  The shell version only ever
> deletes existing .pack files (those in $existing alias existing_packs=
)
> as well as their .idx and .keep files, if present.  It doesn't use a
> glob pattern, unlike remove_pack here.

I'll meditate on that.=20

Thanks for all the other remarks. Now the code looks much more
git-ish, similar to other commands.=20
The lines of code went down from 411 to 385, I guess we can cut off
more inefficiencies there.=20

As you suggested, maybe we should juts have one helper function to
read in the pack directory and keeping all the information (complete fi=
lename),
so we do not need to find the exact filename later again by looping ove=
r
the directory again.

Stefan
