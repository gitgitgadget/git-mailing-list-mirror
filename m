From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: Corporate firewall braindamage
Date: Thu, 10 Apr 2008 18:03:32 -0700
Organization: Linux Kernel Organization, Inc.
Message-ID: <47FEB8E4.3070306@kernel.org>
References: <47FE8277.8070503@zytor.com> <7v7if5wbdd.fsf@gitster.siamese.dyndns.org> <20080410233328.GQ10274@spearce.org> <47FEA7AE.1050403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	ftpadmin <ftpadmin@kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 11 03:04:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk7h5-0007Oj-6q
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 03:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145AbYDKBD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 21:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbYDKBD6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 21:03:58 -0400
Received: from terminus.zytor.com ([198.137.202.10]:35955 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757014AbYDKBD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 21:03:57 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m3B13YEp008993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Apr 2008 18:03:35 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m3B13XF8014535;
	Thu, 10 Apr 2008 18:03:33 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m3B13Wmg000784;
	Thu, 10 Apr 2008 18:03:33 -0700
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <47FEA7AE.1050403@zytor.com>
X-Virus-Scanned: ClamAV 0.92.1/6005/Tue Feb 26 14:01:21 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79261>

H. Peter Anvin wrote:
> Shawn O. Pearce wrote:
>>
>> Funny you say that.  This was a GSoC 2008 project idea.  We even
>> received an application from a student for it.
>>
>> The hard part is either making the server side stateful, so it can
>> remember what the last RCP call had said it wants/haves, or doing a
>> stateless protocol where the client uses an exponential expansion
>> (or some such behavior) of its have list until the server replies
>> with the pack data.
>>
> 
> One easy way of doing the former is to have a session reassociator in 
> the flow; pretty much a multiplexer which receives the HTTP request, and 
> passes it onto a work slave (which can be an ordinary process, in fact, 
> can be the ordinary git daemon) based on a session and sequence ID.
> 

s/multiplexer/demultiplexer/

The best might be to turn the demultiplexer either into an Apache module 
or some scripting language which can run inside Apache (e.g. mod_perl) 
to avoid Apache spawning a CGI program which is only used to talk to the 
git daemon backend.

	-hpa
