From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 04 Apr 2007 15:34:44 +0200
Message-ID: <4613A974.60808@dawes.za.net>
References: <200704041414.14797.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 15:35:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ5dr-0002MD-Se
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 15:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbXDDNfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 09:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbXDDNfL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 09:35:11 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:55967 "EHLO
	spunkymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753807AbXDDNfK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2007 09:35:10 -0400
Received: from [192.168.201.103] (dsl-146-24-118.telkomadsl.co.za [165.146.24.118])
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id 85D447FA9;
	Wed,  4 Apr 2007 06:35:08 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <200704041414.14797.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43739>

Andy Parkins wrote:
> Previously, a binary file in the diffstat would show as:
> 
>  some-binary-file.bin       |  Bin
> 
> The space after the "Bin" was never used.  This patch changes binary
> lines in the diffstat to be:
> 
>  some-binary-file.bin       |  Bin 12345 -> 123456 bytes
> 
> The very nice "->" notation was suggested by Johannes Schindelin, and
> shows the before and after sizes more clearly than "+" and "-" would.
> If a size is 0 it's not shown (although it would probably be better to
> treat no-file differently from zero-byte-file).
> 
> The user can see what changed in the binary file, and how big the new
> file is.  This is in keeping with the information in the rest of the
> diffstat.
> 
> The diffstat_t members "added" and "deleted" were unused when the file
> was binary, so this patch loads them with the file sizes in
> builtin_diffstat().  These figures are then read in show_stats() when
> the file is marked binary.
> 
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> This is a resend; I still wish for it every time I see a --stat with
> binary files changed.
> 
> Is there any objection to it that I can address?


Well, how about my comments in <45E67978.9030805@dawes.za.net>, 
suggesting that the edit difference (number of steps required to 
transform one to the other) would be a better indication?

I think it is better because it is consistent with what we currently do 
for text files: show the number of lines added/deleted.

For binary files, it would be consistent to show the number of bytes 
added/deleted. I have not investigated the output format for the 
libxdiff binary patch format, but hopefully it would not be too 
difficult to calculate the deletions and additions.

Rogan
