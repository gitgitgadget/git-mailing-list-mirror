From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC v2 0/4 resend] Re: fast-import: use struct hash_table
Date: Wed, 11 Apr 2012 07:12:59 -0500
Message-ID: <20120411121259.GB19568@burratino>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:13:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHwQC-0007a3-SK
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 14:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270Ab2DKMNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 08:13:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65358 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab2DKMNH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 08:13:07 -0400
Received: by yhmm54 with SMTP id m54so351550yhm.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q9Lc9VNa+PEy+3MO/7yGPZx3I6a6B8jYzdjAjDHLmMg=;
        b=g1d1J4YiwGA2BX9PitrjSX5cMjyxshKdysGGvDabXqaLwLCThb8vSJfgTd8N3kB6uM
         ydSr7JgKa5oz6IGvgmEFbu1UpZIYGqjjyDTDMEa1xPop3PDMgbaJq8HJh4ez4zsMezKL
         p/YTALFZXZYIm7jCb/6uEgy9p8DHDOfGryte+bxN7F8tSX9KOWubD79b44YFZY4aF9Vv
         epRqoL+7alrhXyf+tPEWDgO2l7/a2Eoih1rycEqXO9HZltOiPZxqLe/SGIMrObbhFmjU
         jGhDd2RAsZl6oXPZcD8AEVKIVTpPGRshnRrxUnteQvojoZ4Mjyqrt7fDsR0T7/QmgjNX
         4hnw==
Received: by 10.50.219.194 with SMTP id pq2mr1788294igc.18.1334146386046;
        Wed, 11 Apr 2012 05:13:06 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id kn3sm24854715igc.15.2012.04.11.05.13.05
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 05:13:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195171>

(resending with newer address for David.  Sorry for the noise)
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
