From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 06:05:45 +0200
Message-ID: <574D0D99.6080303@alum.mit.edu>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
 <vpqlh2remhy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 31 06:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7awf-0006KO-M7
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 06:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbcEaEGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 00:06:03 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50346 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750749AbcEaEGB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 00:06:01 -0400
X-AuditID: 12074413-473ff700000008c7-0d-574d0d9bb6e9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 5A.54.02247.B9D0D475; Tue, 31 May 2016 00:05:47 -0400 (EDT)
Received: from [192.168.69.130] (p508EABD0.dip0.t-ipconnect.de [80.142.171.208])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4V45jL9024241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 31 May 2016 00:05:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <vpqlh2remhy.fsf@anie.imag.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqDub1zfcoP2RpcXkDfdYLe42ZVh0
	Xelmsrj0eT2rxdWtNxktdk++xOjA5nG1OcBj4pfjrB6fN8kFMEdx2yQllpQFZ6bn6dslcGfM
	nNXEWDBRsmLq62nMDYzzRLoYOTkkBEwkzrU9YO9i5OIQEtjKKDHjz1MmCOcCk8S+nyeYQKqE
	BRwlzt06zAZiiwgUSsx69B2qYw2jxIu/F8E6mAUWMEp8OXoXrINNQFdiUU8zmM0roC3RtPAc
	YxcjBweLgKpEV1s4SFhUIETi/LqtrBAlghInZz5hASnhBCqfva0WJMwsoCex4/ovVghbXmL7
	2znMExj5ZyHpmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJTSjcx
	QgJYeAfjrpNyhxgFOBiVeHgZOn3ChVgTy4orcw8xSnIwKYnyWv0GCvEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLhfcbkGy7Em5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg
	PcwD1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPisn4YmBUgqR4gPby8ILsLS5I
	zAWKQrSeYtTlOLL/3lomIZa8/LxUKXFeJW6gIgGQoozSPLgVsHT1ilEc6GNh3hUgl/AAUx3c
	pFdAS5iAlsRn+IAsKUlESEk1MBrdb6hKtgqv2vz/E+d59ss2An6+Tx9euG/GvLT3s9w7+9Ur
	X86/ceCtpR5ndXpFzEe2MmV7kUMenyZuu2KdmRFd53WZd2nD7G/55dvr1XIWhhrF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295948>

On 05/30/2016 02:52 PM, Matthieu Moy wrote:
> [...]

I feel bad bikeshedding about names, especially since you took some of
the original names from my RFC. But names are very important, so I think
it's worth considering whether the current names could be improved upon.

When reading this patch series, I found I had trouble remembering
whether "preallocated" meant "preallocated and movable" or "preallocated
and immovable". So maybe we should brainstorm alternatives to
"preallocated" and "fixed". For example,

* "growable"/"fixed"? Seems OK, though all strbufs are growable at least
to the size of their initial allocation, so maybe "growable" is misleading.

* "movable"/"fixed"? This maybe better captures the essence of the
distinction. I'll use those names below for concreteness, without
claiming that they are the best.

> * strbuf_attach() calls strbuf_release(), which allows reusing an
>   existing strbuf. strbuf_wrap_preallocated() calls strbuf_init which
>   would override silently any previous content. I think strbuf_attach()
>   does the right thing here.

Hmmm....

I think the best way to answer these questions is to think about use
cases and make them as easy/consistent as possible.

I expect that a very common use of strbuf_wrap_fixed() will be to wrap a
stack-allocated string, like

    char pathbuf[PATH_MAX];
    struct strbuf path;

    strbuf_wrap_fixed(&path, pathbuf, 0, sizeof(pathbuf));

In this use case, it would be a shame if `path` had to be initialized to
STRBUF_INIT just because `strbuf_wrap_fixed()` calls `strbuf_release()`
internally.

But maybe we could make this use case easier still. If there were a macro

    #define STRBUF_FIXED_WRAPPER(sb, buf, len) { STRBUF_FIXED_MEMORY,
sizeof(buf), (len), (buf) }

then we could write

    char pathbuf[PATH_MAX];
    struct strbuf path = STRBUF_FIXED_WRAPPER(pathbuf, 0);

I think that would be pretty usable. One would have to be careful only
to wrap arrays and not `char *` pointers, because `sizeof` wouldn't work
on the latter. The BARF_UNLESS_AN_ARRAY macro could be used here to add
a little safety.

(It would be even nicer if we could write

    struct strbuf path = STRBUF_FIXED(PATH_MAX);

and it would initialize both path and a pathbuf variable for it to wrap,
but I don't think there is a way to implement such a macro. So I think
the only way to squeeze this onto one line would be to make it look like

    DEFINE_FIXED_STRBUF(path, PATH_MAX);

But that looks awful, so I think the two-line version above is preferable.)

Similarly, there could be a macro

    #define STRBUF_MOVABLE_WRAPPER(sb, buf, len) { 0, sizeof(buf),
(len), (buf) }

If you provide macro forms like these for initializing strbufs, then I
agree with Matthieu that the analogous functional forms should probably
call strbuf_release() before wrapping the array. The functions might be
named more like `strbuf_attach()` to emphasize their similarity to that
existing function. Maybe

    strbuf_attach_fixed(struct strbuf *sb, void *s, size_t len, size_t
alloc);
    strbuf_attach_movable(struct strbuf *sb, void *s, size_t len, size_t
alloc);

Michael
