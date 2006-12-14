X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Avoid accessing a slow working copy during diffcore operations.
Date: Thu, 14 Dec 2006 14:57:07 +0100
Message-ID: <81b0412b0612140557u225ca00du5b15823d05fda4b9@mail.gmail.com>
References: <20061214111557.GA24297@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 13:57:37 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qNqILMq8h/zAv2C1li1SDliqTnSqikZp1fD7E0cX3T7s2sXMtLpmGBKx6/w8GoRnLaJiKIcwArwINUQkCitcazYBU2jQdt1KXNRogNO6GN2cfNIIf1UONTK5WX1Tlycy4doySt3vs+v0KKujcNhd+ouIugrTmo7TIAwTv/nd6jA=
In-Reply-To: <20061214111557.GA24297@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34337>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gur5V-0007q2-5C for gcvg-git@gmane.org; Thu, 14 Dec
 2006 14:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932734AbWLNN5L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 08:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbWLNN5K
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 08:57:10 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:42441 "EHLO
 nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932734AbWLNN5I (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 08:57:08 -0500
Received: by nz-out-0506.google.com with SMTP id s1so248156nze for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 05:57:08 -0800 (PST)
Received: by 10.78.185.7 with SMTP id i7mr706297huf.1166104627451; Thu, 14
 Dec 2006 05:57:07 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 14 Dec 2006 05:57:07 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On 12/14/06, Shawn O. Pearce <spearce@spearce.org> wrote:
> If Git is compiled with NO_FAST_WORKING_DIRECTORY set then we will
> avoid looking at the working directory when the blob in question
> is available within a packfile and the caller doesn't need the data
> unpacked into a temporary file.

