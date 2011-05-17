From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Maint-only commits
Date: Tue, 17 May 2011 11:13:55 -0400
Message-ID: <BANLkTinAGwJvJuZ_1Y1SK_EhrC0bj2cHHw@mail.gmail.com>
References: <7vliy6jo8c.fsf@alter.siamese.dyndns.org>
	<32603283.31527.1305642038158.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue May 17 17:14:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMLyE-0006CS-JK
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 17:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab1EQPN4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 11:13:56 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:48844 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab1EQPNz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 11:13:55 -0400
Received: by pxi16 with SMTP id 16so403487pxi.4
        for <git@vger.kernel.org>; Tue, 17 May 2011 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z4+D4t1fGSwlcEOMgIQlknbZJXdjWZn0iw6lvW9h2lY=;
        b=hyvfQcm2GLKMVsMCJRhLcOqHimj299+EHSKrqB1GPUFBixINJ6hm+sZWye2TQV+NVw
         NUKZImh8TZBxnnTNaW58rH9z3psT6jv2yvSAaT9mMsVdPTY7NIeF2EbuUvNUGEM9Ny+p
         Cz8ONjt171NXDrbD5GVpNpusQeRWY7ENXSsWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TmT05NNFpaANGWoL3RANQXndirVExyMn5btSJbAWBU3uxmUc9svE5U5p+jDDWqEwBC
         2qCDSsZK1AS5JFY5VnuNTYP7Y8I4i7/OS10I0Zkv0Yvv03bYIF7zN4KByzcoxTJVhm/8
         YC9FQCBJh5H2NXiEldxSV3K7QBy7wgerUCP4o=
Received: by 10.143.28.6 with SMTP id f6mr500891wfj.169.1305645235206; Tue, 17
 May 2011 08:13:55 -0700 (PDT)
Received: by 10.142.200.15 with HTTP; Tue, 17 May 2011 08:13:55 -0700 (PDT)
In-Reply-To: <32603283.31527.1305642038158.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173802>

On Tue, May 17, 2011 at 10:20 AM, Stephen Bash <bash@genarts.com> wrote=
:
> That's certainly a valid approach. =C2=A0I discussed it around the of=
fice and got push back on adding additional complexity to our branching=
 model. =C2=A0So I'll document the "our" merge approach and perhaps rev=
isit the branching model at the beginning of the next development cycle=
=2E

At @work we use something like this. We have three branches:

- trunk (aka master, but it started as a git-svn branch long ago...)
- release
- maint

Our maint merges to both trunk and release, via an automated process
except when a conflict requires human intervention.

Occasionally someone will put something on trunk by accident that
should've gone to maint. We revert it from trunk, cherry-pick to
maint, and let it merge back down.

(Aside, I've found hudson^wjenkins to be great for misc jobs like this
and prefer it to cron these days for non-sytem-related periodic
events.)

j.
