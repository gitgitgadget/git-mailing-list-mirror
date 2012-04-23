From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Custom Merge
Date: Mon, 23 Apr 2012 14:59:47 +0200
Message-ID: <4F955243.2090103@viscovery.net>
References: <loom.20120423T141242-348@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jose Ricardo <josericardo.jr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 15:00:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMIs1-0001Ni-E6
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab2DWM7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 08:59:53 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26751 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab2DWM7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:59:52 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SMIsG-0007Vn-Ny; Mon, 23 Apr 2012 15:00:13 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 148531660F;
	Mon, 23 Apr 2012 14:59:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <loom.20120423T141242-348@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196125>

Am 4/23/2012 14:25, schrieb Jose Ricardo:
> In my project, I have a lot of image files, that I wanted to process using 
> a different tool. For this, after reading some posts about custom merge 
> drivers in this forum, I make the following modifications:
> 
> In the file .gitconfig I added the following lines:
> 
> 
> [merge "imgfile"]
>         name = Driver for image files
>         driver = /usr/local/bin/git-merge-img.sh %O %A %B %L
>         recursive = binary
> 
> and in the .gitinfoattributes I put:
> 
> *.png   merge=imgfile
> 
> As I can see, it works calling my custom script during a merge between
>  two branches that have a .png file. Unfortunately, even after a successfully 
> merge, the final image is not merged with the one in the other branch. 
> In order to test it, I've called my script using three images, giving me the 
> corrected result.
> 
> I don't know if it could help but instead of changing the content of the file
>  I create another one with the same name during a merge operation.

I have my image merge script configured it like this:

[merge "imgfile"]
	driver = imgmerge %O %A %B %A

but if you do that, you must be sure that the script does not need to
access $2 after it has begun writing to $4.

(I know that it worked because at one time I had forgotten that I have a
custom merge driver, and was expecting a merge conflict due to an image
file, but there was no conflict, and the result was correct ;-)

-- Hannes
