From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 19:27:00 +0200
Message-ID: <20090421192700.181f8503@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Apr 21 19:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwJm2-0005Rp-6H
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 19:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbZDUR1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 13:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbZDUR1K
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 13:27:10 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:48224 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZDUR1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 13:27:09 -0400
Received: by fxm2 with SMTP id 2so2647731fxm.37
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=rp1QDLA/HRuLeqoRMw+w3WkAMI6CvEC7YqliNznxq+k=;
        b=I+hK6ORTNxwYxJkLVfQwmyMnrEXYjrM+x8895jE6AJi7ylkmF/vQhAVLyqGellTDZX
         rxEmoL0Y+SI13yfJgq3dr0i9B7nQEZPKi3SoRPfKAIhoiLCYzfKAVqvm5cpFETt0s0gU
         z7kDaqFWIYUhY1KGYlSdisbW3HoWnbNwZKoxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=A91KLQ5Wrbg1aDx3rMudync0fWgAvz4CxFT9WpHb3KriMAB8soewTpm9GI+cVEKxaD
         o1cu0PL8Xv9BfhMHS9HcK3QjSAu4EdD6y/lJLCeUfqN7j/SA7xSi3MTPOYA0B2+U+r1f
         aje6eb8l19a3uvMefCW6fALsEDtYXI7FRXhCc=
Received: by 10.86.31.19 with SMTP id e19mr1546781fge.45.1240334826286;
        Tue, 21 Apr 2009 10:27:06 -0700 (PDT)
Received: from localhost (77-253-150-63.adsl.inetia.pl [77.253.150.63])
        by mx.google.com with ESMTPS id e20sm4184458fga.25.2009.04.21.10.27.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Apr 2009 10:27:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904211100350.10279@pacific.mpi-cbg.de>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117139>

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
> @@ -343,7 +343,7 @@ static struct string_list *get_renames(struct merge_options *o, struct string_list_item *item;
>  		struct rename *re;
>  		struct diff_filepair *pair = diff_queued_diff.queue[i];
> -		if (pair->status != 'R') {
> +		if (pair->status != 'R' || !re->pair->one->size) {
>  			diff_free_filepair(pair);
>  			continue;
>  		}

This doesn't work for me (actually, it segfaults, "re" has just been
declared). However, removing "re->" solves the problem.

---

 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d6f0582..9c2a77f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -343,7 +343,7 @@ static struct string_list *get_renames(struct merge_options *o,
 		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = diff_queued_diff.queue[i];
-		if (pair->status != 'R') {
+		if (pair->status != 'R' || !pair->one->size) {
 			diff_free_filepair(pair);
 			continue;
 		}
