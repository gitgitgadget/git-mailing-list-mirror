From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Improved three-way blob merging code
Date: Thu, 29 Jun 2006 09:43:02 +0200
Message-ID: <81b0412b0606290043s15e19b9fl853627e815f009ff@mail.gmail.com>
References: <Pine.LNX.4.64.0606282157210.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Davide Libenzi" <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 09:43:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvrB7-0005JT-1b
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 09:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWF2HnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 03:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbWF2HnF
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 03:43:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:13246 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932723AbWF2HnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 03:43:03 -0400
Received: by ug-out-1314.google.com with SMTP id a2so190859ugf
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 00:43:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K2PSEOAtlVlRdFomhOWnOmEDm6DZjQY5FNCLc3U4t/0dZQpJdoIm7u53h50siFBwv3e4uiNIeJxW9+QGUMa987SR/+X62vx94mqzPKVKOgJkZgOzwNnHW/TIEuJRYKyLoqkj3BcyRannN+zVi3sb9UtQgUGJELAaZfDzQWNVZvc=
Received: by 10.78.139.5 with SMTP id m5mr909611hud;
        Thu, 29 Jun 2006 00:43:02 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Thu, 29 Jun 2006 00:43:02 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606282157210.12404@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22846>

On 6/29/06, Linus Torvalds <torvalds@osdl.org> wrote:
> +static void *three_way_filemerge(mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
> +{
...
> +       if (t1 && t2 && t3) {
> +               int code = run_command("merge", t2, t1, t3, NULL);

This does not use the labels of merge(1) and the merged file will contain
the names of temporary files at conflict places, which is very confusing if
you happen to loose context while doing a merge with lots of conflicts.
