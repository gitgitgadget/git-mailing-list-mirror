From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: large files and low memory
Date: Mon, 04 Oct 2010 12:24:43 -0600
Message-ID: <4CAA1BEB.3050908@workspacewhiz.com>
References: <20101004092046.GA4382@nibiru.local> <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: weigelt@metux.de, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:24:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pia-0003is-HR
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147Ab0JDSYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:24:48 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:58959 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab0JDSYs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:24:48 -0400
Received: (qmail 12277 invoked by uid 399); 4 Oct 2010 12:24:46 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.144.122)
  by hsmail.qwknetllc.com with ESMTPAM; 4 Oct 2010 12:24:46 -0600
X-Originating-IP: 75.220.144.122
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158085>

  ----- Original Message -----
From: Shawn Pearce
Date: 10/4/2010 12:05 PM
> On Mon, Oct 4, 2010 at 2:20 AM, Enrico Weigelt<weigelt@metux.de>  wrote:
>> when adding files which are larger than available physical memory,
>> git performs very slow. Perhaps it has to do with git's mmap()ing
>> the whole file. Is there any way to do it w/o mmap (hoping that
>> might perform a bit better) ?
> The mmap() isn't the problem.  Its the allocation of a buffer that is
> larger than the file in order to hold the result of deflating the file
> before it gets written to disk.  When the file is bigger than physical
> memory, the kernel has to page in parts of the file as well as swap in
> and out parts of that allocated buffer to hold the deflated file.
>
> This is a known area in Git where big files aren't handled well.
As a curiosity, I've always done streaming decompression with zlib using 
minimal buffer sizes (64k, perhaps).  I'm sure there is good reason why 
Git doesn't do this (delta application?).  Do you know what it is?

Josh
