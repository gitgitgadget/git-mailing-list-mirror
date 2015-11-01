From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 16/26] refs.c: move ref iterators to the common code
Date: Sun, 01 Nov 2015 05:39:32 +0100
Message-ID: <56359784.2060606@alum.mit.edu>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com> <1445998467-11511-17-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 05:47:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZskY7-0002iG-Iy
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 05:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbbKAEqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 00:46:50 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61993 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816AbbKAEqu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2015 00:46:50 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Nov 2015 00:46:49 EDT
X-AuditID: 1207440f-f79df6d000007c0f-b8-56359787e03d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D2.BB.31759.78795365; Sun,  1 Nov 2015 00:39:35 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB24F4.dip0.t-ipconnect.de [93.219.36.244])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA14dWQ3005808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 1 Nov 2015 00:39:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1445998467-11511-17-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqNs+3TTMYOJmOYv5m04wWnRd6Way
	aOi9wmzxb0KNA4vHgk2lHhcvKXsseH6f3ePzJrkAlihum6TEkrLgzPQ8fbsE7ozutXuZC44J
	VHx9/YatgfENbxcjB4eEgInE2Q3aXYycQKaYxIV769m6GLk4hAQuM0rMvDmBCSQhJHCOSeL3
	WXeQel4BbYnFzcEgYRYBVYljv+Yxg9hsAroSi3qawcpFBYIkVix/wQhi8woISpyc+YQFxBYR
	cJC4vOsoWD2zgK/EiyfPwWxhAW+Jt2t+sUDsbWOUuLP/HitIglPAS6K5bT07RIOexI7rv1gh
	bHmJ7W/nME9gFJiFZMcsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRropebWaKX
	mlK6iRESyPw7GLvWyxxiFOBgVOLhdfhhEibEmlhWXJl7iFGSg0lJlJf5J1CILyk/pTIjsTgj
	vqg0J7X4EKMEB7OSCO+XTtMwId6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwM
	B4eSBK/WNKBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCcxhcDIxUkxQO0Nw+k
	nbe4IDEXKArReopRUUqcNwgkIQCSyCjNgxsLS0+vGMWBvhTmNQOp4gGmNrjuV0CDmYAGi+wx
	BBlckoiQkmpgLF810eziryNF/3OvaW6xtPC+IWYn4rZk1W73NQL1/gf0tO5IBOuts1P9+mJb
	ju7X4HPlHj5z8r2ndP6wTPj4p7uv4ifXjukSde3fD3zYdCrsZ6ZsMOu8w+btfwxO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280605>

On 10/28/2015 03:14 AM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 82 ---------------------------------------------------------
>  refs.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 82 deletions(-)
> 
> diff --git a/refs-be-files.c b/refs-be-files.c
> index c5cc7e7..d04a9d2 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> [...]
> @@ -1950,37 +1933,6 @@ int for_each_ref_in_submodule(const char *submodule, const char *prefix,
>  {
>  	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
>  }
> -
> -int for_each_tag_ref(each_ref_fn fn, void *cb_data)
> -{
> -	return for_each_ref_in("refs/tags/", fn, cb_data);
> -}
> -
> -int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> -{
> -	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
> -}
> -
> -int for_each_branch_ref(each_ref_fn fn, void *cb_data)
> -{
> -	return for_each_ref_in("refs/heads/", fn, cb_data);
> -}
> -
> -int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> -{
> -	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
> -}
> -
> -int for_each_remote_ref(each_ref_fn fn, void *cb_data)
> -{
> -	return for_each_ref_in("refs/remotes/", fn, cb_data);
> -}
> -
> -int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> -{
> -	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
> -}
> -
>  int for_each_replace_ref(each_ref_fn fn, void *cb_data)
>  {
>  	return do_for_each_ref(&ref_cache, git_replace_ref_base, fn,

Nit: you deleted one LF too many in the above hunk, leaving no blank
line between the function definitions.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
