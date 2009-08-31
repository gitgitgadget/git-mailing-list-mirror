From: Antony Stubbs <antony.stubbs@gmail.com>
Subject: Re: [script] find largest pack objects
Date: Mon, 31 Aug 2009 15:25:57 +0200
Message-ID: <C0EFE78F-97D6-4287-832A-568AA07031A7@gmail.com>
References: <A67AA762-487D-4CFB-B555-718C88C5787D@gmail.com> <alpine.LFD.2.00.0907092332030.21547@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 15:26:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi6uE-0005rZ-Ei
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 15:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbZHaN0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 09:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbZHaN0f
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 09:26:35 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:63392 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbZHaN0e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 09:26:34 -0400
Received: by ewy2 with SMTP id 2so302136ewy.17
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=KDwWvjoPXbTCXBGFP3lcYRt0lKU/sxqySWUAk2TLcgs=;
        b=WfpSZ/NVr6wXXv+kE9v+F+/ortwSVFzJI7R3mJGd1ElideSsG5NDscoo4/BNqjpGoX
         NdYt7xhqJ+/sh3CJFiL6qkK/jqkh/1kHBAKy3PBmge/vX8NGS8QYOgyhuXvxvvABL8tv
         WIyH1+M46BeiOlIsZ3RurXUiDGueVZVamEYWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=s+jC+SiJRa3LpvHOtAK3NIzu9o6rB6Bkxl42beBtpBnYZn/EaXz2fthksFoDGLALDf
         b+EoPnpaIIz6mILyovSea7XkegMZv9+8Cpkwr1qltlZgUpk/A9iov8t6pTynZVcL5P8X
         WG8FuIeFcSw2kJ5u9bIo1BDTZ8VdFSoj/irNo=
Received: by 10.211.200.7 with SMTP id c7mr4421522ebq.54.1251725192666;
        Mon, 31 Aug 2009 06:26:32 -0700 (PDT)
Received: from ?192.168.1.157? (82-204-13-170.dsl.bbeyond.nl [82.204.13.170])
        by mx.google.com with ESMTPS id 23sm184760eya.38.2009.08.31.06.26.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Aug 2009 06:26:31 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0907092332030.21547@xanadu.home>
X-Mailer: Apple Mail (2.1075.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127482>

Sorry Nicolas,
Completely missed your message amongst the torrent of the git mailing  
list - which I'm now unsubscribed from.. But sure, I'll ad this to my  
todo list :)

Cheers,
Antony Stubbs,

sharca.com

On 10/07/2009, at 5:34 AM, Nicolas Pitre wrote:

> On Fri, 10 Jul 2009, Antony Stubbs wrote:
>
>> Blog post about git pruning history and finding large objects in  
>> your repo:
>> http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/
>>
>> This is a script I put together after migrating the Spring Modules  
>> project
>> from CVS, using git-cvsimport (which I also had to patch, to get to  
>> work on OS
>> X / MacPorts). I wrote it because I wanted to get rid of all the  
>> large jar
>> files, and documentation etc, that had been put into source  
>> control. However,
>> if _large files_ are deleted in the latest revision, then they can  
>> be hard to
>> track down.
>>
>> #!/bin/bash
>> #set -x
>>
>> # Shows you the largest objects in your repo's pack file.
>> # Written for osx.
>> #
>> # @see
>> http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/
>> # @author Antony Stubbs
>>
>> # set the internal field spereator to line break, so that we can  
>> iterate
>> easily over the verify-pack output
>> IFS=$'\n';
>>
>> # list all objects including their size, sort by size, take top 10
>> objects=`git verify-pack -v .git/objects/pack/pack-*.idx | grep -v  
>> chain |
>> sort -k3nr | head`
>>
>> echo "All sizes are in kB's. The pack column is the size of the  
>> object,
>> compressed, inside the pack file."
>>
>> output="size,pack,SHA,location"
>> for y in $objects
>> do
>> 	# extract the size in bytes
>> 	size=$((`echo $y | cut -f 5 -d ' '`/1024))
>> 	# extract the compressed size in bytes
>> 	compressedSize=$((`echo $y | cut -f 6 -d ' '`/1024))
>> 	# extract the SHA
>> 	sha=`echo $y | cut -f 1 -d ' '`
>> 	# find the objects location in the repository tree
>> 	other=`git rev-list --all --objects | grep $sha`
>> 	#lineBreak=`echo -e "\n"`
>> 	output="${output}\n${size},${compressedSize},${other}"
>> done
>>
>> echo -e $output | column -t -s ', '
>
> This is certainly useful.  Mind submitting a patch adding this  
> script to
> contrib/stats/ ?
>
>
> Nicolas
