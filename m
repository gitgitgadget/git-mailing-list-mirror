From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 04 Aug 2006 09:01:40 -0700
Message-ID: <44D36F64.5040404@gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>	 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>	 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>	 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>	 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>	 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org> <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 18:01:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G927R-0008PB-Tu
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 18:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161272AbWHDQBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 12:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161273AbWHDQBq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 12:01:46 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:3236 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161272AbWHDQBq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 12:01:46 -0400
Received: by py-out-1112.google.com with SMTP id t32so361024pyc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 09:01:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VXNCWVQYioamc/zcN91s6AnCtn130AOhsRWQZXW/+oOhqZ6HZbiDJb10QapjnIpFm4WQEzj1zjPqtSHvnG2Rp7YATH7keaiLmUztPWYBCyB40WuiUmwvh8A4LOabPxspAgURW3jTXe7IVoOw4QGb1pcIi3cHP09S1JMYcS1wAFM=
Received: by 10.35.9.15 with SMTP id m15mr5220624pyi;
        Fri, 04 Aug 2006 09:01:43 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.32.187.210])
        by mx.gmail.com with ESMTP id n77sm704411pye.2006.08.04.09.01.41;
        Fri, 04 Aug 2006 09:01:42 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
In-Reply-To: <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24801>

Jon Smirl wrote:
> On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> I'd suggest against it, but you can (and should) just repack often enough
>> that you shouldn't ever have gigabytes of objects "in flight". I'd have
>> expected that with a repack every few ten thousand files, and most files
>> being on the order of a few kB, you'd have been more than ok, but
>> especially if you have large files, you may want to make things "every 
>> <n>
>> bytes" rather than "every <n> files".
> 
> How about forking off a pack-objects and handing it one file name at a
> time over a pipe. When I hand it the next file name I delete the first
> file. Does pack-objects make multiple passes over the files? This
> model would let me hand it all 1M files.
> 

Why don't you just write the pack file directly? Pack files without 
deltas have a very simple structure, and git-index-pack will create a 
pack index file for the pack file you give it.
