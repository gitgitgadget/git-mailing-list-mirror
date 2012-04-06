From: Kevin <compufreak@gmail.com>
Subject: Re: Question: how to have ls-files use the .gitignore in the index
Date: Fri, 6 Apr 2012 13:21:13 +0200
Message-ID: <20120406112113.GA4528@ikke-laptop.buyways.nl>
References: <A5E8E180685CEF45AB9E737A010799805DFACA@cdnz-ex1.corp.cubic.cub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Holding, Lawrence" <Lawrence.Holding@cubic.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 13:21:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG7EK-0005Gr-Ep
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 13:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab2DFLVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 07:21:19 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54412 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923Ab2DFLVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 07:21:18 -0400
Received: by eekc41 with SMTP id c41so668427eek.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AWO1CFPZJ3F9xg6Wkf6esRY+m3m8RDsBIEBOCUAtCFo=;
        b=o+VlMRAHjNl+N47bVnvBeyZNfsZjHFJAvJob/vVaCXWb5tQtizbKfxAHK0y7gPHYzL
         MEmGPe1eI9fV2kCoxpaxm0PfYLT9ZHkZxkAEb2gPhT3Riw24luBuE1e+I39ZFACliHI9
         Gmu2Sr2UDMRYO4I9SlMOWxu4zPFw9O2nd3fL4OycJrmUtWk1JcdSDgX2HGd3sacskc0v
         6/SPiMKGmY0X5mU4UDk404ggOa/anYfZpLeEmjXJiW/3G1kvkRCN0OPlmO84WhTb6a7G
         dgJepYGuWCQwBMbrdw2R4tfB93Gna0vheB08dpID41s+K4C62I6l1pCbeCkiqc56GWig
         FhUQ==
Received: by 10.213.22.137 with SMTP id n9mr687084ebb.156.1333711277380;
        Fri, 06 Apr 2012 04:21:17 -0700 (PDT)
Received: from localhost (D4B2749A.static.ziggozakelijk.nl. [212.178.116.154])
        by mx.google.com with ESMTPS id n56sm24155481eeb.4.2012.04.06.04.21.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 04:21:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A5E8E180685CEF45AB9E737A010799805DFACA@cdnz-ex1.corp.cubic.cub>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194865>

What I would do is check out the file from the index to a temporary
file, and use that as an exclude file.

You can probably use git checkout-index in combination with --temp to
create the file.

Kevin

On Tue, Apr 03, 2012 at 11:07:08AM +1200, Holding, Lawrence wrote:
> I have a pre-commit hook that checks the index for files that match the
> ignores / excludes in the repository. But sometimes this will run on a
> repository where not all the folders are up-to-date with the tip, and
> will then test against the working tree versions of these files and not
> those in the index.
> 
> from pre-commit:
> 
> 	if git ls-files -i --exclude-standard | grep .
> 	then
> 	    exit 1
> 	fi 
> 
> Is there an option to have ls-files use the excludes in the index
> without checking out the whole file tree?
> 
> Thanks,
