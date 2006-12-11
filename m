X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Mon, 11 Dec 2006 09:59:55 +0100
Message-ID: <200612110959.56492.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612102359.20083.jnareb@gmail.com> <46a038f90612101816j33870bb1j39182358440aaa40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 08:57:50 +0000 (UTC)
Cc: "Jeff Garzik" <jeff@garzik.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W5LQVGGjmK4foTHAiY8Cv5KVb3e7WVFJfPG1vtx2mWBkO29XOH+9S7ZkLu8GHY8CvbiZtrktsEAxANqPqVxbUK8LKyUqVgnobHv2hMX1Xrcsz9KFbmtGntabB2OEujErFgcCXhRRmEkviKxOr0BIa5yyEmOT4ZCBkMNX/9RS8Ms=
User-Agent: KMail/1.9.3
In-Reply-To: <46a038f90612101816j33870bb1j39182358440aaa40@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33979>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtgyn-0003MI-NF for gcvg-git@gmane.org; Mon, 11 Dec
 2006 09:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762661AbWLKI5l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 03:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762662AbWLKI5k
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 03:57:40 -0500
Received: from hu-out-0506.google.com ([72.14.214.234]:11120 "EHLO
 hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762661AbWLKI5k (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 03:57:40 -0500
Received: by hu-out-0506.google.com with SMTP id 36so822183hui for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 00:57:38 -0800 (PST)
Received: by 10.67.19.20 with SMTP id w20mr9487387ugi.1165827458400; Mon, 11
 Dec 2006 00:57:38 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id p32sm5336540ugc.2006.12.11.00.57.37; Mon, 11 Dec
 2006 00:57:38 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

Martin Langhoff wrote:
> On 12/11/06, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> Even if Apache does execute CGI script to completion every time, it might
>> not send the output of the script, but HTTP 304 Not Modified reply. Might.
>> I don't know if it does.
> 
> It is up to the script (CGI or via mod_perl) to set the status to 304
> and finish execution. Just setting the status to 304 does not
> forcefully end execution as you may want to cleanup, log, etc.

I was thinking not about ending execution, but about not sending script
output but sending HTTP 304 Not Modified reply by Apache.

I meant the following sequence of events:
 1. Script sends headers, among those Last-Modified and/or ETag
 2. Apache scans headers (e.g. to add its own), notices that Last-Modified
    is earlier or equal to If-Modified-Since: sent by browser or reverse
    proxy, or ETag matches If-None-Match:, and sends 304 instead of script
    output
 3. Script finishes execution, it's output sent to /dev/null

Again, I don't know if Apache (or any other web server) does that. 
-- 
Jakub Narebski
