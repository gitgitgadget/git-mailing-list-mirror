From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 26/44] refs.c: move copy_msg to the common code
Date: Tue, 13 Oct 2015 11:25:17 +0200
Message-ID: <561CCDFD.7040103@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-28-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 11:25:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlvq2-0000Fr-JQ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 11:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbbJMJZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 05:25:36 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:55857 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751373AbbJMJZc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 05:25:32 -0400
X-AuditID: 1207440c-f79e16d000002a6e-dd-561ccdffac17
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 83.03.10862.FFDCC165; Tue, 13 Oct 2015 05:25:19 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D9PH2d021881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 05:25:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-28-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqPv/rEyYwbGXYhbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDNWLbUo+MlV0XduBVsD40mOLkZODgkBE4nZ
	J9qYIGwxiQv31rN1MXJxCAlcZpRY+OoEE4RzlknixtVr7CBVvALaEqtX32IBsVkEVCXO7njA
	BmKzCehKLOppBpskKhAksWL5C0aIekGJkzOfgNWLCDhIXN51lBnEFhZwk9gxfxPUgjZGiY8X
	dgAlODg4Bbwkrn2VAqlhFtCT2HH9FyuELS+x/e0c5gmM/LOQjJ2FpGwWkrIFjMyrGOUSc0pz
	dXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3MUICkmcH47d1MocYBTgYlXh4X0TKhAmxJpYV
	V+YeYpTkYFIS5dXcDRTiS8pPqcxILM6ILyrNSS0+xCjBwawkwpvUApTjTUmsrEotyodJSXOw
	KInzqi5R9xMSSE8sSc1OTS1ILYLJynBwKEnw1p4BahQsSk1PrUjLzClBSDNxcIIM55ISKU7N
	S0ktSiwtyYgHRWR8MTAmQVI8QHuzQdp5iwsSc4GiEK2nGBWlxHlzQRICIImM0jy4sbA084pR
	HOhLYd5ZIFU8wBQF1/0KaDAT0GAjdimQwSWJCCmpBkbWq8wPbtSy1LhxV3LInH/uteH8Jp91
	iTls3gn8S18l+SvkiOgzLOy/NpGz17jwcdK7D0H+F5+pRz1dckzgQKj0YgPOzccKfBYVXplV
	KT6fa8s197/14sJ5r5dMDGfV5J5UoimSExVvGycy57jhK6Z2z/XK3Q7dG2XZrv93 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279491>

On 10/12/2015 11:51 PM, David Turner wrote:
> Rename copy_msg to copy_reflog_msg and make it public.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 28 +---------------------------
>  refs.c          | 26 ++++++++++++++++++++++++++
>  refs.h          |  2 ++
>  3 files changed, 29 insertions(+), 27 deletions(-)
> 
> [...]
> diff --git a/refs.c b/refs.c
> index 2515f6e..bd8c71b 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -886,6 +886,32 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
>  	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
>  }
>  
> +/*
> + * copy the reflog message msg to buf, which has been allocated sufficiently
> + * large, while cleaning up the whitespaces.  Especially, convert LF to space,
> + * because reflog file is one line per entry.
> + */

Please put the docstring by the declaration in the header file.

> [...]
> diff --git a/refs.h b/refs.h
> index 7a936e2..3da5d09 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -597,6 +597,8 @@ enum ref_type {
>  
>  enum ref_type ref_type(const char *refname);
>  
> +int copy_reflog_msg(char *buf, const char *msg);
> +
>  enum expire_reflog_flags {
>  	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
>  	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
