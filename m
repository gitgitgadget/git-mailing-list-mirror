X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/RFC] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Thu, 30 Nov 2006 18:14:50 +0100
Message-ID: <81b0412b0611300914u521a5351idde23618c2fbf017@mail.gmail.com>
References: <200611301259.32387.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 17:15:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KyNCE5FQrO8AUVNDSeDEnkhWTLs2mVzzyTpyO4k+fvgo8daABZII500qsbFEsjdhewvWaZgxT1D5uAKJsCLWuqj0BTUxf2311vljcej5zw1dP61nWUNLKregMTR3s/QBM9/iJJGZn6FzOgwNWFEOtXUMRAFkBKui6B/nM5Sk/V0=
In-Reply-To: <200611301259.32387.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32779>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GppVG-0005sI-Qa for gcvg-git@gmane.org; Thu, 30 Nov
 2006 18:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030804AbWK3ROw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 12:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030820AbWK3ROw
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 12:14:52 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:2342 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1030804AbWK3ROw
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 12:14:52 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1373439nze for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 09:14:51 -0800 (PST)
Received: by 10.78.164.13 with SMTP id m13mr3738939hue.1164906890638; Thu, 30
 Nov 2006 09:14:50 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 30 Nov 2006 09:14:50 -0800 (PST)
To: "Andy Parkins" <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/30/06, Andy Parkins <andyparkins@gmail.com> wrote:
> "Maybe we could do git-commit -a  _only_ if the index matches HEAD, and
> otherwise keep current behavior?  So people who don't care about the
> index won't get tripped up, and when you do have a dirty index, you get
> told about it?"

The is dangerous on filesystems which lie to the programs about file metadata.
The "virtual filesystem" of cygwin is one of this kind: exec-bit of
the files depend
on its contents. Just calling git-commit -a will commit executability
at this particular
moment. For whatever reason, disabling handling of the exec-mode in gits config
does not work.

If you about to change the behaviour, provide at least a config option
to go back
