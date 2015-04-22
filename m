From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] git-multimail: Add an option to filter on branches
Date: Wed, 22 Apr 2015 13:44:54 +0200
Message-ID: <553789B6.7030501@alum.mit.edu>
References: <1429657487-10809-1-git-send-email-daveboutcher@gmail.com>	<55377A60.707@alum.mit.edu> <CAEXuECi=UDo7_0O22+Gi1yew1M=LrrKLXNT9gdSvdgQwCxYjow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Dave Boutcher <daveboutcher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 13:45:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykt5h-0000mx-DR
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 13:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653AbbDVLpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 07:45:12 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43525 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754870AbbDVLpL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 07:45:11 -0400
X-AuditID: 12074412-f79e46d0000036b4-bb-553789b726f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 82.84.14004.7B987355; Wed, 22 Apr 2015 07:44:55 -0400 (EDT)
Received: from [192.168.69.130] (p4FC971D5.dip0.t-ipconnect.de [79.201.113.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3MBis47009885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 22 Apr 2015 07:44:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAEXuECi=UDo7_0O22+Gi1yew1M=LrrKLXNT9gdSvdgQwCxYjow@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1N3eaR5qsOqytsWWHT+ZLbqudDM5
	MHnsnHWX3ePzJrkApihum6TEkrLgzPQ8fbsE7oxzvw+yFTRwVaz4f4ixgfEHexcjJ4eEgInE
	/KZHbBC2mMSFe+uBbC4OIYHLjBIfXm4HSwgJXGCSePg+HsTmFdCWOHn4HSOIzSKgKvFo43Ew
	m01AV2JRTzMTiC0qECTRem0qI0S9oMTJmU9YQGwRAS2JLROmAdVwcDALiEv0/2MBMYUFvCXW
	z+GDWLucUeLdvGZWkHJOgUCJLT/PgN3JLKAu8WfeJWYIW16ieets5gmMArOQbJiFpGwWkrIF
	jMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3MULCVGgH4/qTcocYBTgYlXh4
	V7CbhwqxJpYVV+YeYpTkYFIS5X1WDhTiS8pPqcxILM6ILyrNSS0+xCjBwawkwttQD5TjTUms
	rEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLgDegAahQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHxWl8MTBSQVI8QHvzQNp5iwsSc4GiEK2nGBWlxHmLQRICIImM
	0jy4sbDk84pRHOhLYd5kkCoeYOKC634FNJgJaHDcNhOQwSWJCCmpBsb6parnexe/aAhh+Cx+
	Ys8h8fVyN9qnJ1dJqijsf/V+m2Dz3YTXIhrzdW+pZfQ0MXA4fe1/tcni1fJr/0JDsth95Ipu
	5vIr+rTbbd62IyAw7TX/xf8b3M7m7u/ZckvZ//N7RYvG0rx1xu31fdWG3+cvig2y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267588>

On 04/22/2015 12:46 PM, Dave Boutcher wrote:
> The only code I'm not fond of is matching on a list of regular
> expressions.  There must be a more pythonic way to do:
> 
> + return [x for x in [r.match(branch) for r in branches] if x]
> 
> which basically returns true if "branch" matches any regular
> expression in the list.

I think what you are looking for is

    return any(r.match(branch) for r in branches)

This also has the advantage of stopping processing as soon as it finds a
match.

I was also wondering why you decided to support comma-separated lists of
regexps *and* multivalued config settings. It seems that supporting only
multivalued settings would suffice.

Maybe you are following the precedent of our email configuration
settings, which support comma-separated lists of email addresses? If so,
I don't think that is necessary. The email support is there for
backwards compatibility and because comma-separated email addresses are
a thing in RFC 2822. Neither of these arguments apply to branch regexps.

> I pushed this change out to our production git server (its good to be
> the king.)  I'll obviously update here if it does anything too
> unfortunate.

Thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
