From: Thomas Harning <harningt@gmail.com>
Subject: Re: [PATCH] This patch is to allow 12 different OS's to compile and run git.
Date: Fri, 6 Jun 2008 15:46:23 -0400
Message-ID: <D11671CD-8F0B-4572-A988-EC6BC6B38A46@gmail.com>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 21:47:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4huG-0004iQ-3m
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 21:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbYFFTq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 15:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbYFFTq3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 15:46:29 -0400
Received: from hs-out-0708.google.com ([64.233.178.250]:55784 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764572AbYFFTq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 15:46:28 -0400
Received: by hs-out-0708.google.com with SMTP id 4so826470hsl.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=ZbrMqrgvGUbLGDPAnIe5SV8BMXCaoxqexEUypp9GyTg=;
        b=JGAXVHHuWOIKVlj7Yliw7BIhhPcZlEcjtqMiL7OD6Xt+nE6FnGtcen9dWpeJAO10kL
         kWDPfvsAKU2bZuGZyYU3w9H0vXUzepCvI3jAFZ0avTTpDdkH/0uPcSEbcuHNyHNUNeq4
         9ePMDyREYMoTg/ccF2Gwkx7ZyOCkDt4zSWND4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=XBqgFdFFz8MqsjIW/PjkC9e0ogizgpsONFyer6QK3WuSBLPXXSFXt1iIMqeHYRx/DY
         QQ1dsoP15b/YlJj1vqaZCcc/MoCsgg6FvUjnrI4JbrEZK3RRU7QgsKjQnqFzdNh+xZMT
         me5dESnXHispUfnKM7c3rOy20aFcbpkf/K6x8=
Received: by 10.90.79.12 with SMTP id c12mr549330agb.1.1212781587179;
        Fri, 06 Jun 2008 12:46:27 -0700 (PDT)
Received: from ?10.1.10.130? ( [75.149.208.122])
        by mx.google.com with ESMTPS id p33sm8519541elf.3.2008.06.06.12.46.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 12:46:26 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84102>


On Jun 6, 2008, at 3:34 PM, Boyd Lynn Gerber wrote:
>
> #ifdef SNPRINTF_RETURNS_BOGUS
> #define snprintf git_snprintf
> diff --git a/progress.c b/progress.c
> index d19f80c..11a0841 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -241,7 +241,8 @@ void stop_progress_msg(struct progress  
> **p_progress, const char *msg)
> 	*p_progress = NULL;
> 	if (progress->last_value != -1) {
> 		/* Force the last update */
> -		char buf[strlen(msg) + 5];
> +		/* char buf[strlen(msg) + 5]; */
> +		char *buf = malloc (strlen(msg) + 5 );
> 		struct throughput *tp = progress->throughput;
Hrm... malloc w/o free... perhaps you should use a something like  
alloca /IFF/ C99/gnu isn't available for the dynamic buffer  
allocation...
