From: John <john@puckerupgames.com>
Subject: serious performance issues with images, audio files, and other "non-code"
 data
Date: Wed, 12 May 2010 14:53:53 -0400
Message-ID: <4BEAF941.6040609@puckerupgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 12 20:55:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCH5G-0006ph-Eu
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 20:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab0ELSy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 14:54:59 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:41459 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577Ab0ELSy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 14:54:58 -0400
Received: from postalmail-a2.g.dreamhost.com (caiajhbdcahe.dreamhost.com [208.97.132.74])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 0F50C1873A1
	for <git@vger.kernel.org>; Wed, 12 May 2010 11:54:56 -0700 (PDT)
Received: from [10.3.1.118] (unknown [65.202.33.238])
	by postalmail-a2.g.dreamhost.com (Postfix) with ESMTP id E99DB111D91
	for <git@vger.kernel.org>; Wed, 12 May 2010 11:54:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146957>

Hi,

We're seeing serious performance issues with repos that store media files, even relatively small 
files. For example, a web site with less than 100 MB of images can take minutes to commit, push, or 
pull when images have changed.

Our first guess was that git is repeatedly attempting to compress/decompress data that had already 
been compressed. We tried these configuration settings (shooting in the dark) to no avail:

    core.compression 0   ## Docs say this disables compression. Didn't seem to work.
    pack.depth 1     ## Unclear what this does.
    pack.window 0    ## No idea what this does.
    gc.auto 0        ## We hope this disables automatic packing.

Our guess that re-compression is to blame may not even be valid since we can manually re-compress 
these files in seconds, not minutes.

Is there a trick to getting git to simply "copy files as is"?  In other words, don't attempt to 
compress them, don't attempt to "diff" them, just store/copy/transfer the files as-is?

Thanks,
  -John
