From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] http: support sending custom HTTP headers
Date: Wed, 27 Apr 2016 08:29:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604270829180.2896@virtualbox>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de> <921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de> <xmqq8u00i9pp.fsf@gitster.mtv.corp.google.com> <20160426171238.GA7609@sigill.intra.peff.net>
 <xmqq4maoi8x8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 08:29:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avIyo-0004bs-Ps
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 08:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbcD0G3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 02:29:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:56781 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbcD0G3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 02:29:42 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M2LZc-1bnGZo0fXY-00s7m9; Wed, 27 Apr 2016 08:29:36
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq4maoi8x8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:hRwBo1B8nwC1IqYT5Wb5aBkGkilly9no8m6XWVkaNw5njPqgO/1
 UDoTvsjgUSXAj0L58VaEO+5XK7z5ySVx2sg4shRPOK8aq0ixF8xcV26NT0yoshtL4UUnOCj
 UoZ22imDDsqx2oBm6oQO4twYyzlGOtlSOBoomGvCFYH5Mj+ZLB9DlXnN9iVBCso4zGoVDDC
 VN5kU/Ru9LnE6vjpPd6ng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dj/zzRgmtf8=:Bp1Wf8ZuxfXxM9004eXRbu
 aMVLg5yqqjW9zJb7XCVFHsk1hNVrMxozBHSGTLcSpywnv4308brBQ4ytuYQcI6zvxEjnxU9a5
 6ElnHDEoxM/VaRLufxFXHaQwyRRcTQgtnvQP4mgQ0Cg5iVCz4ndlre0kywivkI3RAFfzKQuRn
 SorpkhAN30Xmm/FOawCnZHODb7YMbKsQxLE5RKc0Oe1ej/QChkCaT3o3gF4bxbpZ+B6pvXuti
 tWRFx4WijzJ9+lSQCfvuKGeniu3FZHG0JTOrNu9ltAMRKi/QXxB65SzPLpYm4ZYVQH76tkFWp
 AGnR0G9pNDZl1cVatLY8PhycTSFmowiBDZmxRqoG/vRVd6AYfTYbqDZRIozJIansFl9ZC1gJd
 5w+V5Tdqale+i/+0JngOd8lf86NulUXOD3mXSb6zfrpHHFoSBOv//NQ3VcnRnQ5RXwdz4133y
 Yoab8L0qOs/Q/Q57Yk6vZ0oUwpveNsCWSU6dn/tVWlOK5hlruvB8SMocsf59dfQ4ysYAICqN5
 DqSyP4EFi1exIss6IqRlBV/Pnz8E9t3y/riXPq0FMQFB9lybyeWxuajRapPCh3t5KWkh1KX8j
 9Zwwl+tZA4/4nxmGiP4UbKz3cUdMwVuhmLT9dSP2dZ8CACm5WTaCDwoIq1N5nEwDNdCV9Ugq8
 TrE9zhh7+1RPOfAT/Ij0wJerkne5UvNlbZAGaotrWefDhXQ1bl3pQ2JswbE7L35ixF9RBnuVw
 fFzQwRH0IAfxg7TaO1n0EXpgXL5TkR7aF5MHyBoCVolC4LIQdBH00P3sit+87bo3bqrHO7ic 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292707>

Hi Junio,

On Tue, 26 Apr 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But I think this block (even before my patch) also needs to handle the
> > case where "value" is NULL (presumably by complaining with
> > config_error_nonbool).
> 
> OK, so squashes found to be necessary so far amounts to the attached
> patch.

Thanks.
Dscho
