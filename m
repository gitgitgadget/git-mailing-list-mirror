From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] unpack-trees: record which unpack error messages
 should be freed
Date: Mon, 21 May 2012 15:43:50 -0500
Message-ID: <20120521204350.GC28331@burratino>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
 <20120521145610.1911.60207.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 21 22:44:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWZSV-0005hh-5f
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 22:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758546Ab2EUUn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 16:43:59 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61532 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758480Ab2EUUn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 16:43:58 -0400
Received: by gglu4 with SMTP id u4so4767754ggl.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=l7cB8gyAQksDNjBnX1kjY4oIga15iwEZSMg3fC+YhDQ=;
        b=gua6v5XM/VYRSmWFELYco8Ih8Vl7vDXtdlL5oXgKGMACDiQumAVTosyB6EKqC356Us
         Aeuc/Luh3xrtyy+2nDoevpenePGLFUjWFcCTrwYrbsiUe9bbduWw4swJfez3DpiK4kzD
         UW8yXLalOCYkG2ffEf4tagqLFRQxwiBFLYbA3LuCJcnygixXjqfzCeN7RdqYu9GeWBHY
         UQCRIQPg+DcsD+eq68tX+hi78pBFE3ck8Yaa4Wpb7tQL3UqJlerjY+RZ7u2gNSvr96rs
         DAaNrqkpnUzuN5Ua65W/nUNbvmw4/oYqWwofFAdEXj0d3It1s7O5ueotop5y4qVDLfzj
         3eTw==
Received: by 10.50.186.132 with SMTP id fk4mr7830911igc.56.1337633037108;
        Mon, 21 May 2012 13:43:57 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nh8sm23747694igc.1.2012.05.21.13.43.55
        (version=SSLv3 cipher=OTHER);
        Mon, 21 May 2012 13:43:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120521145610.1911.60207.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198128>

Christian Couder wrote:

> "struct unpack_trees_options" has a "const char *msgs[]" field
> that is setup with string values in setup_unpack_trees_porcelain().

Hmm.  Incidentally, should callers (e.g., the 100 single-picks
involved in a large multi-pick) be reusing these strings instead of
allocating them again and again?
