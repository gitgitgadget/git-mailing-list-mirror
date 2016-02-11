From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 08/21] refs: add methods to init refs db
Date: Thu, 11 Feb 2016 09:54:21 +0100
Message-ID: <56BC4C3D.8040505@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-9-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 10:01:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTn7y-0000ht-CA
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 10:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcBKJB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 04:01:26 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50590 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752743AbcBKJB0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2016 04:01:26 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2016 04:01:25 EST
X-AuditID: 1207440e-befff70000000398-82-56bc4c3fb1d4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 1B.44.00920.F3C4CB65; Thu, 11 Feb 2016 03:54:23 -0500 (EST)
Received: from [192.168.69.130] (p548D69E5.dip0.t-ipconnect.de [84.141.105.229])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1B8sLOT000576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 11 Feb 2016 03:54:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-9-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqGvvsyfM4NAFIYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bm3HhxmKdjJXtHeeJi1gfEmaxcjJ4eEgInE
	r4m9bF2MXBxCAlsZJVp2T2IHSQgJXGCSuNJgA2ILC9hLHP3fwARiiwg4SFzedZQZoqGVUaLv
	6kY2kASbgK7Eop5msCJeAW2J758PM4PYLAKqEgsfb2YBsUUFQiTef33OClEjKHFy5hOwOKeA
	h8SPVb1gvcwCehI7rv9ihbDlJba/ncM8gZFvFpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1
	Wbc4OTEvL7VI11gvN7NELzWldBMjJPT4djC2r5c5xCjAwajEw/ujZneYEGtiWXFl7iFGSQ4m
	JVHeg257woT4kvJTKjMSizPii0pzUosPMUpwMCuJ8DrbAuV4UxIrq1KL8mFS0hwsSuK8akvU
	/YQE0hNLUrNTUwtSi2CyMhwcShK8vN5AjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUl
	GfGg2IsvBkYfSIoHaK82SDtvcUFiLlAUovUUoy7Hgh+31zIJseTl56VKifO6ghQJgBRllObB
	rYAlmleM4kAfC/N6g1TxAJMU3KRXQEuYgJbs+L4LZElJIkJKqoFRv33WkZu5m//+ehacdCsj
	d4nIjtV+oY4cqr/vPeZfrSE1wYerTsfh5Dbm2peeJ05fctLaxNPMLRkhuPNxz3GPzm2fJi6x
	mfEm9V+rySaLaR9PHJLb7GcuK/ntCPvHNsfL668fnjz3l6bgxbor0YbKjpLXK14G 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285955>

On 02/05/2016 08:44 PM, David Turner wrote:
> Alternate refs backends might not need the refs/heads directory and so
> on, so we make ref db initialization part of the backend.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/init-db.c    | 20 ++++++++++----------
>  refs.c               |  5 +++++
>  refs.h               |  2 ++
>  refs/files-backend.c | 16 ++++++++++++++++
>  refs/refs-internal.h |  2 ++
>  5 files changed, 35 insertions(+), 10 deletions(-)
> 
> [...]
> diff --git a/refs.h b/refs.h
> index 5bc3fbc..c5ecc52 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -66,6 +66,8 @@ extern int ref_exists(const char *refname);
>  
>  extern int is_branch(const char *refname);
>  
> +extern int refs_init_db(struct strbuf *err, int shared);

The convention elsewhere is for "struct strbuf *err" to be the *last*
parameter.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
