From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Sat, 9 Apr 2011 11:58:09 +0700
Message-ID: <BANLkTimCbr+hnJNGWDBVbjZKEBDW1KR4=g@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com> <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org> <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org> <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org> <7vaag01gdl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 06:58:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8QFy-0007HL-1H
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 06:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab1DIE6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 00:58:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54487 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab1DIE6k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 00:58:40 -0400
Received: by bwz15 with SMTP id 15so3300423bwz.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 21:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=RBdkwC/CNSF3QZ1ulrpjgLItUcNsLHIZVmmfqRY94vE=;
        b=B4GVrqjVYq0qB3XonrvglED2uEAnDByLe2AeQQUx37H7/JSK/2boBtrRBiWZm53NB/
         YhZDfdujtQzf3lOt2f7pkyf6B1jHJiKZ7aiZwrKQSE/oxqhshlN2x3KfcmndH6nIqnEB
         fEdOy2COS7l9bp/4lavcnyciC8vUn8gFsA+r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qzfkTRHtwzjXa2y65UjkTLp1Tio/4bnJymIYxukDxvxzWCyVc4D7ZvXylkm9+KXZxV
         mjtDHG5Fp2vzij8s4Of3vnUQuVzN2eA+c22BiHaVznixTNq4MpggQiFEwaIo1sPY6Msk
         GCHPQQduVvoyx9MT70AtDNiQphfOBk5pXIGR8=
Received: by 10.204.22.205 with SMTP id o13mr747602bkb.71.1302325119101; Fri,
 08 Apr 2011 21:58:39 -0700 (PDT)
Received: by 10.204.37.195 with HTTP; Fri, 8 Apr 2011 21:58:09 -0700 (PDT)
In-Reply-To: <7vaag01gdl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171182>

On Sat, Apr 9, 2011 at 6:18 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Also make ':' without anything else to mean "there is no pathspec". =C2=
=A0This
> would allow differences between "git log" and "git log ." run from th=
e top
> level of the working tree (the latter simplifies no-op commits away f=
rom
> the history) to be expressed from a subdirectory by saying "git log :=
".

The intention is good, but reality may need more work. I assume that
"git add -u :" is equivalent to "git add -u" (or "git add -u ." to be
precise). Unfortunately, cmd_add() checks argc for no arguments to
turn "add -u <nothing>" to "add -u .", not the result from
get_pathspec(). It can be fixed. Just heads up as there can be similar
traps elsewhere.
--=20
Duy
