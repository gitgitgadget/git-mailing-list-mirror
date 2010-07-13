From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH 1/2] lib-rebase.sh: fake-editor.sh: Allow checking of 
	commit header(s) in $GIT_EDITOR
Date: Tue, 13 Jul 2010 09:58:35 +0800
Message-ID: <AANLkTikZaPR0iaUkREU83EAyYPbuTvsB2frksHqLSX41@mail.gmail.com>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
	<7v7hl1fd0n.fsf@alter.siamese.dyndns.org>
	<AANLkTin03Ea2fIBQiSDpIqRYLYjWRe9U62nZpfczbfST@mail.gmail.com>
	<AANLkTik7KDM8Vp_nc1NYRZ89cd1IdyfBffq5vUitbrzj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 03:58:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYUle-0005kM-JL
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 03:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab0GMB6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 21:58:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35131 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab0GMB6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 21:58:37 -0400
Received: by wwi17 with SMTP id 17so600643wwi.1
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 18:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=yhgtYL/sX5yV40vqtai+6HnWAO8pukf5w8ZLbSPNahA=;
        b=E6X3EbaBgwfm4c0BJ8hWOQrI8el7T6syUL/4Ps1a8qGw0yCzsN+yX4u1HmPbjdhW22
         gsbYY1/iWU/rZqDnEdIxT0302fzo4RoaDSGNOt1Iq4a0fB0mMvrzdMTjPlVlTs4t0mi4
         kgrNBEF+xSBYU+I3o62h8OxrNKh0lcdazXtls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WIjP/tUIWo29n6Wd+I/2karJBnadJkmC1oXO6lI5/H1fuK8mJr/Es3t9nSXMvvAGyh
         HxUw5PCWTJHUZzn7zzgefC23TWGaV09xriETVG90vQf+Afxzp/1f2J0kk3HayEPm0iwe
         m+ZlcyWe846mimYxfLd9M5JSvmU3c18MLzr+c=
Received: by 10.227.142.136 with SMTP id q8mr13405262wbu.95.1278986315640; 
	Mon, 12 Jul 2010 18:58:35 -0700 (PDT)
Received: by 10.216.163.142 with HTTP; Mon, 12 Jul 2010 18:58:35 -0700 (PDT)
In-Reply-To: <AANLkTik7KDM8Vp_nc1NYRZ89cd1IdyfBffq5vUitbrzj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150868>

On Tue, Jul 13, 2010 at 8:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Come on ;-) The most portable, traditional and straightforward way to
> spell that would be "[a-z][a-z]*", no?

On Tue, Jul 13, 2010 at 9:39 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> sed 's/^pick [0-9a-f]\{1,\} //'
>
> is a valid posix BRE. Alternately + can be expressed as:
>
> sed 's/^pick [0-9a-f][0-9a-f]* //'

Thanks for the cluestick guys.

On Tue, Jul 13, 2010 at 8:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Somebody is already using test_set_editor inside lib-rebase.sh --- where
> else does it come from other than test-lib?  Don't the scripts that
> include lib-rebase already include test-lib.sh to make test_cmp available
> to you?

On Tue, Jul 13, 2010 at 9:39 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Don't the scripts that source lib-rebase.sh all source test-lib.sh
> ahead of it? lib-rebase.sh shouldn't need to re-source test-lib.sh.
> No?

Ah, sorry for not reporting the exact cause of the problem, it is
actually due to the fact that test_cmp will be called (later) by
"fake-editor.sh", which does not source test-lib.sh, and sourcing
test-lib.sh will not be a correct solution in that case yes?

nazri.
