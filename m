From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC v2 0/4] Re: fast-import: use struct hash_table
Date: Wed, 11 Apr 2012 07:11:16 -0500
Message-ID: <20120411121116.GA19568@burratino>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:11:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHwOa-0006do-OJ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 14:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451Ab2DKML2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 08:11:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52546 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab2DKML1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 08:11:27 -0400
Received: by iagz16 with SMTP id z16so1194994iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6nSxshzhKJEKF1Y1df4awZ0jFlDnEyuCPpVWWUJvfQ8=;
        b=KrfYKDVfQ1yY3lpb9HktdDxhn5q0am8RSmHQtv8R/Szj3hZNDyK+Et9fLNRjfqihfU
         ZUVdSX70J95gEkRIYA+tmd+GbGQaNKvc9dCqis7vJcd9xUvwyORFAvbgAxFtYKeGl0MB
         aIAo6TUAXNU1w4RL22vc2hQjXefuO5/HTChHoLrI8bltbs1rXyELrX87RR7er5LRpXBC
         gB4603Ioin1WxAmBnUF6OfY+ywy/MoA5LUpXwRYVWoyCMh2FnTI8J3yibtX2pnGWJPmY
         sF8uXXUw4Ghvy5WQ9Nl0yS+RfQqjvsvXd4iA8syjhbLUnzbYTeJOItcJEG5jfZc7e+eo
         L/bg==
Received: by 10.50.106.132 with SMTP id gu4mr1703958igb.59.1334146287159;
        Wed, 11 Apr 2012 05:11:27 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gf4sm24852708igb.14.2012.04.11.05.11.25
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 05:11:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195170>

Hi David,

David Barr wrote:

> The current custom hash tables in fast-import.c do not grow.
> This causes poor performance for very large imports.
> Fortunately, we have struct hash_table and friends so there's
> no need to write cumbersome hash table growth code.

Thanks for these patches.  I've tentatively queued the following
patches at

  git://repo.or.cz/git/jrn.git fast-import-pu

and would be happy to ask Junio to pull them if they look sane to you.

Sorry for the long delay.

David Barr (2):
  fast-import: allow object_table to grow dynamically
  fast-import: allow atom_table to grow dynamically

Jonathan Nieder (2):
  fast-import: allow branch_table to grow dynamically
  fast-import: use DIV_ROUND_UP

 fast-import.c |  153 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 102 insertions(+), 51 deletions(-)
