From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH RFC] mailinfo: correctly handle multiline 'Subject:'
	header
Date: Thu, 8 Jan 2009 13:08:13 +0300
Message-ID: <20090108100813.GA15640@myhost>
References: <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Thu Jan 08 11:09:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKrpY-00059E-A9
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 11:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZAHKIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 05:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbZAHKIK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 05:08:10 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:48483 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZAHKIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 05:08:09 -0500
Received: by fk-out-0910.google.com with SMTP id 18so4421145fkq.5
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 02:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=8vy+gl9c6moYW6RwYZuW29YRrxPhPycebP7UhpiMDVE=;
        b=cf9n5UB8W+3hbGp7C2qgTrTS81lIuwBRIp6HfCQLqSb9Srcwax9JL8RhVY8fxemHR3
         M6hvGUf3r/GAzs5iicx0gb8hGgI9oNiyS/8hc7nChZoVtiqbNh+mjPG+0d5UMpCxulEW
         8kSS1zIvNWIEA00Fqer4+20tLJL/ez3i0oNoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ICPxiM+/KmGl35qbG2aAL7051SgSod+J6emtTAcBN1HjTkboxm1/pk7oUZGCDvHmZl
         3qA+rp82pJu8t+N7ilfElCm94cllB2OdwRAPrEdku1Uu1AHTGhzvAzaDRr945aZu1MMC
         Vw8qgVUS7NOD8pMGWL2DhUc2n5zUa3PxgWvLI=
Received: by 10.86.84.18 with SMTP id h18mr14050117fgb.22.1231409287291;
        Thu, 08 Jan 2009 02:08:07 -0800 (PST)
Received: from smtp.gmail.com (ppp83-237-188-32.pppoe.mtu-net.ru [83.237.188.32])
        by mx.google.com with ESMTPS id d4sm45368552fga.31.2009.01.08.02.08.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jan 2009 02:08:06 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Thu, 08 Jan 2009 13:08:13 +0300
Content-Disposition: inline
In-Reply-To: <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104912>

On 21:38 Fri 26 Dec     , Kirill Smelkov wrote:
> When native language (RU) is in use, subject header usually contains several
> parts, e.g.
> 
> Subject: [Navy-patches] [PATCH]
> 	=?utf-8?b?0JjQt9C80LXQvdGR0L0g0YHQv9C40YHQvtC6INC/0LA=?=
> 	=?utf-8?b?0LrQtdGC0L7QsiDQvdC10L7QsdGF0L7QtNC40LzRi9GFINC00LvRjyA=?=
> 	=?utf-8?b?0YHQsdC+0YDQutC4?=
> 

>  t/t5100/info0012    |    5 ++++
>  t/t5100/msg0012     |    7 ++++++
>  t/t5100/patch0012   |   30 +++++++++++++++++++++++++++++
>  t/t5100/sample.mbox |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 112 insertions(+), 2 deletions(-)

The testcases are too long, a minimal mbox with encoded "Subject:" would
be enough to test the mailinfo parser, it's all the you need to test
here.
