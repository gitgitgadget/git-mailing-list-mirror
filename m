From: Dane Jensen <careo@fastmail.fm>
Subject: Re: [Bug] Segfault in git status
Date: Thu, 21 Feb 2008 09:19:21 -0800
Message-ID: <191B6CDE-D81C-4730-8A39-07774BB80D85@fastmail.fm>
References: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm> <D3C27E63-329D-4509-830A-099A7BCB72B7@ai.rug.nl> <76718490802210853t23b0498fkfb9a14bcd50ca458@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Pieter de Bie" <pdebie@ai.rug.nl>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 18:20:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSF5V-0001JD-En
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 18:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759374AbYBURTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 12:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757140AbYBURTZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 12:19:25 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50616 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757073AbYBURTY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2008 12:19:24 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D02A994EEB;
	Thu, 21 Feb 2008 12:19:23 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 21 Feb 2008 12:19:23 -0500
X-Sasl-enc: DRf4zplpKdNFg1HEU43BSmMl6eJ2Godr05PQwjCdF+Qh 1203614363
Received: from [192.168.1.146] (unknown [208.71.31.193])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 27FF02AE5E;
	Thu, 21 Feb 2008 12:19:23 -0500 (EST)
In-Reply-To: <76718490802210853t23b0498fkfb9a14bcd50ca458@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74638>

On Feb 21, 2008, at 8:53 AM, Jay Soffian wrote:

> On Thu, Feb 21, 2008 at 11:01 AM, Pieter de Bie <pdebie@ai.rug.nl>  
> wrote:
>> Vienna:Project pieter$ gdb --args git status
>> (gdb) r
>> Program received signal EXC_BAD_ACCESS, Could not access memory.
>> Reason: KERN_INVALID_ADDRESS at address: 0x004a2010
>> index_name_exists (istate=0xeba80, name=0xbfffdc27 "Data/Cache/
>> Template/Peter_II_of_Yugoslavia.html", namelen=47) at read-cache.c: 
>> 101
>> 101                     if (!(ce->ce_flags & CE_UNHASHED)) {
>> (gdb) print *ce
>> Cannot access memory at address 0x4a1fec
>
> Do that again, but type "bt" at the gdb prompt after the crash  
> please. :-)


Same error as mine. Here's the result against my repository. This is  
with master, git --version => 1.5.4.2.184.gb23b,

(gdb) r
Starting program: /Users/djensen/bin/git status
Reading symbols for shared libraries +++++++. done
# On branch remote/device-emulator

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_INVALID_ADDRESS at address: 0x00431018
index_name_exists (istate=0xe04a0, name=0xbfffdc87 "shared/models/spec/ 
device_spec.rb", namelen=33) at read-cache.c:101
101			if (!(ce->ce_flags & CE_UNHASHED)) {
(gdb) bt
#0  index_name_exists (istate=0xe04a0, name=0xbfffdc87 "shared/models/ 
spec/device_spec.rb", namelen=33) at read-cache.c:101
#1  0x00068624 in dir_add_name (dir=0xbfffefc0, pathname=0xbfffdc87  
"shared/models/spec/device_spec.rb", len=33) at dir.c:374
#2  0x00069731 in read_directory_recursive (dir=0xbfffefc0,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>,  
baselen=19, check_only=0, simplify=0x81de38) at dir.c:642
#3  0x000695cf in read_directory_recursive (dir=0xbfffefc0,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>,  
baselen=14, check_only=0, simplify=<value temporarily unavailable, due  
to optimizations>) at dir.c:627
#4  0x000695cf in read_directory_recursive (dir=0xbfffefc0,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>, baselen=7,  
check_only=0, simplify=<value temporarily unavailable, due to  
optimizations>) at dir.c:627
#5  0x000695cf in read_directory_recursive (dir=0xbfffefc0,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>, baselen=0,  
check_only=0, simplify=<value temporarily unavailable, due to  
optimizations>) at dir.c:627
#6  0x000698f3 in read_directory (dir=0xbfffefc0, path=0xae8a0 ".",  
base=0xae19c "", baselen=4394996, pathspec=0x0) at dir.c:715
#7  0x00094746 in wt_status_print (s=0xbffff5ec) at wt-status.c:282
#8  0x00014423 in run_status (fp=0xa01a65f8, index_file=0x5003b0 "/ 
Users/djensen/Projects/Soocial/source/.git/index", prefix=0x0,  
nowarn=4394996) at builtin-commit.c:346
#9  0x00014e0f in cmd_status (argc=1, argv=0x0, prefix=0x5003b0 "/ 
Users/djensen/Projects/Soocial/source/.git/index") at builtin-commit.c: 
782
#10 0x00001da0 in handle_internal_command (argc=1, argv=0xbffff7f8) at  
git.c:259
#11 0x00001faf in main (argc=1, argv=0xbffff7f8) at git.c:449
(gdb)
