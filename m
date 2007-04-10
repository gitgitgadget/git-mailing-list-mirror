From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 10:40:23 +0200
Message-ID: <20070410084022.GB2813@planck.djpig.de>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 13:06:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbBuN-00005f-Q7
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 10:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966115AbXDJIk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 04:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966120AbXDJIk5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 04:40:57 -0400
Received: from planck.djpig.de ([85.10.192.180]:3235 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966115AbXDJIkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 04:40:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 963C988003;
	Tue, 10 Apr 2007 10:40:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3KZF0l5370m2; Tue, 10 Apr 2007 10:40:46 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id DFD918803D; Tue, 10 Apr 2007 10:40:24 +0200 (CEST)
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44118>

On Mon, Apr 09, 2007 at 09:20:29PM -0700, Linus Torvalds wrote:
> diff --git a/sha1_file.c b/sha1_file.c
> index 4304fe9..ab915fa 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -13,6 +13,7 @@
>  #include "commit.h"
>  #include "tag.h"
>  #include "tree.h"
> +#include "refs.h"
>  
>  #ifndef O_NOATIME
>  #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
> @@ -2332,6 +2333,8 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
>  				     path);
>  		free(target);
>  		break;
> +	case S_IFDIR:
> +		return resolve_gitlink_ref(path, "HEAD", sha1);
>  	default:
>  		return error("%s: unsupported file type", path);
>  	}

Not that I have time right now to look up the exact context (only read
the patch), but I would've expected a "case S_IFDIRLNK:" here?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
