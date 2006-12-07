X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: how to revert changes in working tree?
Date: Thu, 07 Dec 2006 09:42:47 +0800
Message-ID: <45777197.50805@gmail.com>
References: <4576680B.7030500@gmail.com> <81b0412b0612060043t488d356du8f5fcdd164a45eb5@mail.gmail.com> <45769417.70601@gmail.com> <81b0412b0612060220n11fb7e19hc6ed202759962bd3@mail.gmail.com> <4576A60A.3060003@gmail.com> <20061206181302.GA20320@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 01:44:25 +0000 (UTC)
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sIVNrtThM5Z6t3o4263zNZsWa9bOEU41VNwZvgcFvgkxSDEiKgS4HGkL4xn3Q9iXFGAh0wtl7ot5eDJQPUqnlYDFyfOjPsOg9jx0gOevz0k1eBgyMLfDm3PIMV59bG/Vi+HOavQ4NyP7CnweVHAjVT8ckYx3HVnQoC+ZeMHy31A=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <20061206181302.GA20320@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33542>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs8J7-0001OY-MO for gcvg-git@gmane.org; Thu, 07 Dec
 2006 02:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937934AbWLGBoP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 20:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937936AbWLGBoP
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 20:44:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:63564 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937934AbWLGBoO (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 20:44:14 -0500
Received: by wx-out-0506.google.com with SMTP id h27so385760wxd for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 17:44:13 -0800 (PST)
Received: by 10.70.27.18 with SMTP id a18mr2609533wxa.1165455853488; Wed, 06
 Dec 2006 17:44:13 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id 39sm57890wrl.2006.12.06.17.44.10; Wed, 06 Dec 2006 17:44:13 -0800 (PST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> 
> You are just *very unlucky*.  :-)
> 
> The Linux kernel has case sensitive file names.  In other words there
> are two files in the kernel:
> 
>   net/netfilter/xt_MARK.c
>   net/netfilter/xt_mark.c
> 
> and they have different content!  On NTFS or FAT, where filenames
> are not case sensitive, these become the same file.  So Git now
> starts to think that the file was modified, because one of those
> files overwrote the other when they were checked out.
> 
> Moral of the story: You cannot work with the linux.git repository
> on a case insensitive filesystem, like NTFS, FAT (Windows), or HFS+
> (Mac OS X).
> 
Yes, you are very right.

$ git ls-files |tr A-Z a-z | sort | uniq -c |grep -v "1 "
      2 include/linux/netfilter/xt_connmark.h
      2 include/linux/netfilter/xt_dscp.h
      2 include/linux/netfilter/xt_mark.h
      2 include/linux/netfilter_ipv4/ipt_connmark.h
      2 include/linux/netfilter_ipv4/ipt_dscp.h
      2 include/linux/netfilter_ipv4/ipt_ecn.h
      2 include/linux/netfilter_ipv4/ipt_mark.h
      2 include/linux/netfilter_ipv4/ipt_tcpmss.h
      2 include/linux/netfilter_ipv4/ipt_tos.h
      2 include/linux/netfilter_ipv4/ipt_ttl.h
      2 include/linux/netfilter_ipv6/ip6t_hl.h
      2 include/linux/netfilter_ipv6/ip6t_mark.h
      2 net/ipv4/netfilter/ipt_ecn.c
      2 net/ipv4/netfilter/ipt_tos.c
      2 net/ipv4/netfilter/ipt_ttl.c
      2 net/ipv6/netfilter/ip6t_hl.c
      2 net/netfilter/xt_connmark.c
      2 net/netfilter/xt_dscp.c
      2 net/netfilter/xt_mark.c

