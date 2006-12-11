X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 11:00:16 +0100
Message-ID: <81b0412b0612110200j7c27e962va63381ea3c976050@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org>
	 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com>
	 <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org>
	 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com>
	 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org>
	 <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com>
	 <Pine.LNX.4.64.0612101647310.12500@woody.osdl.org>
	 <e5bfff550612102317w331f3b0fyc3c6b095ff21191a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 10:00:31 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SFJq2sqPLsPlGMMinGaLQZ3AG9v3gPIuqI0AfYU/FKF0dA+ZzqMVX2VJ7qOzkYQdCmeiXrR3Kn+78nyp7SOG7GMd5osOenVyLmpDgviefOTBVPIa9INt6j2kJN6rPZtjAetPDVcPy9P4sODgQKPuoM6kYYwRbdAQ4PJr7F8M0F0=
In-Reply-To: <e5bfff550612102317w331f3b0fyc3c6b095ff21191a@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33987>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GthxP-0002Up-Qk for gcvg-git@gmane.org; Mon, 11 Dec
 2006 11:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762706AbWLKKAT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 05:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762711AbWLKKAT
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 05:00:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:40890 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762706AbWLKKAS (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 05:00:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1278600uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 02:00:16 -0800 (PST)
Received: by 10.78.170.17 with SMTP id s17mr1177594hue.1165831216286; Mon, 11
 Dec 2006 02:00:16 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 11 Dec 2006 02:00:16 -0800 (PST)
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/11/06, Marco Costalba <mcostalba@gmail.com> wrote:
>   $ time git rev-list --header --boundary --parents --topo-order HEAD
> /dev/null
> 3.04user 0.05system 0:03.09elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+10141minor)pagefaults 0swaps

here you filtered output of git-rev-list by /dev/null, which makes no sense

> $ time git rev-list --header --boundary --parents --topo-order HEAD >
> /tmp/tmp.txt; cat /tmp/tmp.txt > /dev/null
> 3.44user 0.28system 0:03.74elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+18033minor)pagefaults 0swaps

should be: time { git-rev-list >/tmp/tmp; cat /tmp/tmp >/dev/null; }
