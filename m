From: Matt Sporleder <msporleder@gmail.com>
Subject: Re: low memory system to clone larger repo
Date: Mon, 9 Feb 2015 06:20:07 -0500
Message-ID: <EF215DDC-22ED-426B-9C8D-5BA91E6EEACB@gmail.com>
References: <CAHKF-AspyE84_0CVMz2OjFLt3Q62qKDfTkbUk3-+RQ_EZ=0JGg@mail.gmail.com> <CACsJy8Cx6K3Qdq4hq7T_vxsOR-UJv7+mz9AFSiAeKd3YZxqYHg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 12:20:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKmO2-0007tD-TR
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 12:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759261AbbBILUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 06:20:12 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:40995 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbbBILUL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 06:20:11 -0500
Received: by mail-qg0-f43.google.com with SMTP id i50so9781792qgf.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 03:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kY43lhLzweUF7T+gJISwsKuQMfGDILyGzKZjRIYA8DM=;
        b=Nc4KOY06XipVBIykOfaRqIJLOZQrQB+W9qsSI6Ei0ZL7t2aiVmyu2Hb+dKOGQcYq/B
         TqviX9BPxKBlyitt5kScBbHr7pvHlSMesQ1PHJMs1z5rREW85hu3N9Nh1B0C2hxqH5Kd
         n6UqeuaRxNfCko+3xc9Po4rgBA9XJ3dgPj7wC3d9Zgi221LrOMQsJDAq2UVB8V3pUGl7
         tS7+7Zg77hhA0T0UBvN7pG2KAoVcDSmkyeMGwFrGDNR/XK9WOsY/26F10UgyS0Ads0oi
         AQnoYbxWdyec2I638VJlrf+W3ojhcuBWmU7a/z5vkAyUzfYAQNqhu9QclDLMAuv9ZWSs
         SR/g==
X-Received: by 10.224.30.145 with SMTP id u17mr40461460qac.46.1423480810643;
        Mon, 09 Feb 2015 03:20:10 -0800 (PST)
Received: from [10.72.10.63] ([166.170.58.7])
        by mx.google.com with ESMTPSA id v15sm11541979qav.11.2015.02.09.03.20.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Feb 2015 03:20:09 -0800 (PST)
X-Mailer: iPhone Mail (12B440)
In-Reply-To: <CACsJy8Cx6K3Qdq4hq7T_vxsOR-UJv7+mz9AFSiAeKd3YZxqYHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263562>

A more "final" version of the tuning exercise I did is here:

http://mail-index.netbsd.org/tech-repository/2015/01/08/msg000520.html

I did try some of these setting on the server and it made the repo much much larger so I guess I am looking for ways to just reduce client memory usage/the best balance of disk, memory, and bandwidth. 

If there is a way to turn off some memory hogging speed ups I m interested in trying them. 

I will try to get you the output later since I have since started working on the server side.

Let me know if you want to try some server side stuff and I can give you a git:// or http:// off list. 

Thanks for looking, 
Matt


> On Feb 9, 2015, at 5:40 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> 
>> On Thu, Jan 8, 2015 at 11:10 PM, matthew sporleder <msporleder@gmail.com> wrote:
>> I am attempting to clone this repo: https://github.com/jsonn/src/
>> 
>> and have been successful on some lower memory systems, but i'm
>> interested in continuing to push down the limit.
>> 
>> I am getting more success running clone via https:// than git:// or
>> ssh (which is confusing to me) and the smallest system that works is a
>> raspberry pi with 256 RAM + 256 swap.
>> 
>> I seem to run out of memory consistently around 16% into Resolving
>> deltas phase but I don't notice an RSS jump so that's another
>> confusing spot.
> 
> Sorry for a really late reply. The command that's running when you run
> out of memory is index-pack. I guess it's verifying the delta chain. I
> think it needs enough memory for two uncompressed objects (or files)
> in a delta chain. I haven't finished cloning this repo yet so I don't
> know what these delta chains look like.
> 
> What does it say when it runs out of memory? I'm thinking maybe we
> could force a core dump, then look at how memory is used.
> 
> What if you "git init", then do "git fetch https://..." manually?
> There's an optimization for git-clone that may make index-pack use a
> bit more memory (and push it over the edge)
> 
>> My config is below and I'd appreciate any more suggestions of getting
>> that down to working on a 128MB box (or smaller).
> 
> I suppose it's ~/.gitconfig or /etc/gitconfig, it's not added after
> the clone is complete, correct? Sounds interesting, let me profile its
> memory usage..
> 
>> [pack]
>>        windowMemory = 1m
>>        packSizeLimit = 1m
>>        deltaCacheSize = 1m
>>        deltaCacheLimit = 10
>>        packSizeLimit = 1m
> 
> I think many of these only affect the server side. If you clone from
> github, then they are useless. You may want to provide your own server
> side with these settings and see if things change. Also play with
> pack.depth (affecting server side)
> 
>>        threads = 1
> -- 
> Duy
