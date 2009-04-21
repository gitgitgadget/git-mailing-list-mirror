From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 19:54:34 +0200
Message-ID: <20090421195434.3a01676d@gmail.com>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>
	<alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302>
	<41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk>
	<20090421024433.GC14479@coredump.intra.peff.net>
	<7vskk2bt3x.fsf@gitster.siamese.dyndns.org>
	<fabb9a1e0904210148w4c6b869l396122baef1c0ee3@mail.gmail.com>
	<alpine.DEB.1.00.0904211055160.10279@pacific.mpi-cbg.de>
	<alpine.DEB.1.00.0904211100350.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwKCf-0000HQ-0F
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 19:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbZDURyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 13:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbZDURyl
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 13:54:41 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:41015 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbZDURyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 13:54:40 -0400
Received: by fxm2 with SMTP id 2so2660585fxm.37
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=SQ45w1AAldq9BhtCwvkPgRXSuT/OTs5WKxoWPP74YOs=;
        b=KYv+WdQ8DUDvvSlYBkicT5EeMdqylXGl7G7TwPwmzyWHntjyXHHG9nevHA1Dz9P08J
         33BUcIQY5wBQaFmuMPcB7JXM61G2bQ4cje8Ai13jB9lDrCXusawtNQBLdT2v3hdCDx15
         3H0znqgBmlftN9I4wxHErsM54twdkeDg7eNks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=K0g21Twl8jNIE0qIocn+/0EckdmhKHT7uLqnWrfCgModOXHwem380xU0AOz8dBIMJf
         XGlRYfNTn7J4pesd2rYS61reh37kHDNxfhYGFielSqSdrJe6TBEp201HRJb/5eBSt5Xq
         NhB+BXoxgeyDXZALsRvahXJwFMAQeMQhMBdc8=
Received: by 10.86.68.1 with SMTP id q1mr2011236fga.10.1240336478659;
        Tue, 21 Apr 2009 10:54:38 -0700 (PDT)
Received: from localhost (77-253-150-63.adsl.inetia.pl [77.253.150.63])
        by mx.google.com with ESMTPS id e11sm4217238fga.24.2009.04.21.10.54.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Apr 2009 10:54:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904211100350.10279@pacific.mpi-cbg.de>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117141>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Tue, 21 Apr 2009, Johannes Schindelin wrote:
> 
> > I actually agree with Junio, though, that we want this special
> > handling of empty files only in merge-recursive.
> 
> And this _might_ be enough (not even compile-tested due to lack of
> time; the OP did not provide the test as a proper patch):
> 
> ---
> 
>  merge-recursive.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 774bacd..b7ea3cd 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -343,7 +343,7 @@ static struct string_list *get_renames(struct
> merge_options *o, struct string_list_item *item;
>  		struct rename *re;
>  		struct diff_filepair *pair =
> diff_queued_diff.queue[i];
> -		if (pair->status != 'R') {
> +		if (pair->status != 'R' || !re->pair->one->size) {
>  			diff_free_filepair(pair);
>  			continue;
>  		}
> --

And here is a test case:

---

 t/t6035-merge-suspected-rename.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/t/t6035-merge-suspected-rename.sh b/t/t6035-merge-suspected-rename.sh
new file mode 100755
index 0000000..81615fd
--- /dev/null
+++ b/t/t6035-merge-suspected-rename.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='Merge-recursive merging suspected rename'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo "hello" > date &&
+	git add date &&
+	git commit -m initial &&
+
+	git branch parallel &&
+
+	echo "hello" > LICENSE &&
+	cp LICENSE LICENSE-copy &&
+	git add LICENSE &&
+	git commit -m LICENSE &&
+
+	git rm date &&
+	git commit -m removed &&
+
+	git checkout parallel &&
+	date > date &&
+	git add date &&
+	git commit -m date
+'
+
+test_expect_success 'merge' '
+	git checkout master &&
+	test_must_fail git merge parallel &&
+	test_cmp LICENSE LICENSE-copy
+'
+
+test_done
