From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Wed, 20 Aug 2014 20:34:43 +0200
Message-ID: <53F4EA43.4020802@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>	<1403275409-28173-44-git-send-email-sahlberg@google.com>	<53BC07FC.8080601@alum.mit.edu>	<20140715180424.GJ12427@google.com>	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>	<CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>	<53F4B642.7020002@alum.mit.edu> <CAL=YDW=zmqwjLzjWYLGCjwb_aQTofTJ-CrmPgoq3KKJjfHR3XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 20:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKAii-0003xW-6H
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 20:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbaHTSer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 14:34:47 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45911 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751867AbaHTSeq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2014 14:34:46 -0400
X-AuditID: 12074413-f79ed6d000002501-d6-53f4ea45a7c4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 95.80.09473.54AE4F35; Wed, 20 Aug 2014 14:34:45 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2242.dip0.t-ipconnect.de [93.219.34.66])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s7KIYhrv006605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 20 Aug 2014 14:34:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <CAL=YDW=zmqwjLzjWYLGCjwb_aQTofTJ-CrmPgoq3KKJjfHR3XQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1HV99SXYYO08DYuuK91MFm9vLmG0
	+DehxoHZY+esu+weCzaVenzeJBfAHMVtk5RYUhacmZ6nb5fAnXFo/RrWgq+8FSdnLWdqYOzi
	7mLk4JAQMJH4cU60i5ETyBSTuHBvPVsXIxeHkMBlRokbtyezgySEBM4xSfxdng9i8wpoSzw6
	2ckI0ssioCox4QA/SJhNQFdiUU8zE4gtKhAkMfvzPHaIckGJkzOfsIDYIgKaEjf7T4PVMAvE
	STzdMY0NxBYWSJC42nGSFWLvemaJdYdfMoMkOAUCJc7N3wy2i1lAXWL9PCGIXnmJ7W/nME9g
	FJiFZMUshKpZSKoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJWeEd
	jLtOyh1iFOBgVOLhvbHoS7AQa2JZcWXuIUZJDiYlUV6TF0AhvqT8lMqMxOKM+KLSnNTiQ4wS
	HMxKIrz114ByvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJXvGXQI2C
	RanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoBiNLwZGKUiKB2ivJEg7b3FBYi5QFKL1
	FKOilDivJsixAiCJjNI8uLGwRPSKURzoS2FefZB2HmASg+t+BTSYCWjw1sUfQQaXJCKkpBoY
	w799zfqx7WBMUK2/XvnjqO6Q04yaz+6fmjVBqr7E+/wGJquiA3fqP4S9y153ObiTVZ95inOY
	1eeMuLa+SAZeUeubop/uPHWLnOBnztbcwvZ20vOM77y+3hqBP/dH3zT7/EThxcWm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255580>

On 08/20/2014 06:28 PM, Ronnie Sahlberg wrote:
> On Wed, Aug 20, 2014 at 7:52 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> I'm a little worried that abandoning *all* refname checks could open us
>> up to somehow trying to delete a "reference" with a name like
>> "../../../../etc/passwd".  Either such names have to be prohibited
>> somehow, or we have to be very sure that they can only come from trusted
>> sources.
> 
> I only set this flag from builtin/branch.c so it should only be used
> when a user runs 'git branch -D' from the command line.
> All other places where we delete branches we should still be checking
> the rename for badness.
> 
> That said, unless the "rules for good refname" changes in the future,
> which is unlikely, is should be exceptionally rare that a user ends up
> with a bad refname in the first place.
> Perhaps my example I gave was bad since if you manually create bad
> refs using echo > .git/refs/heads/...  then you should probably know
> how to fix it too and thus maybe we do not need this patch in the
> first place.
> 
> Do you want me to delete this patch and resend this part of the series
> ? Or is the 'only works for branch -D from the commandline' sufficient
> ?
> I have no strong feelings either way so I will just follow what you decide.

I think that if you run the refname through normalize_path_copy_len()
and that function returns (1) without an error, (2) without modifying
its argument, and (3) the result does not begin with a
has_dos_drive_prefix() or is_dir_sep(), then we should be safe against
directory traversal attacks.  I suggest doing this kind of check even if
not doing the full check_refname_format() check.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
