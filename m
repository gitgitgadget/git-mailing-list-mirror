From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG/RFC] Raw diff output format (git-diff-tree) and --relative[=<path>] option
Date: Thu, 8 Jul 2010 14:19:42 +0200
Message-ID: <201007081419.42702.jnareb@gmail.com>
References: <201007051015.26995.jnareb@gmail.com> <201007081300.18712.jnareb@gmail.com> <20100708114125.GA2427@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 14:20:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWq58-0000Nk-If
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 14:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126Ab0GHMTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 08:19:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41758 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab0GHMTw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 08:19:52 -0400
Received: by fxm14 with SMTP id 14so361359fxm.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 05:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GdV9feznmQSn05f42Ksh4Xful4nVKJb05TemoR/EhGQ=;
        b=HqmW7UGN3aZoFF8ElhkExbyVcY6z9qOFcKjvFek4XwIhKplZDL/xzsfwfugf4C7ste
         HpgW3DCj2NkR6xcTIs0Jq0TlX3MdO+SXJl/OFmjk0RD9ArHD8BfZrRanWIQxXFzfFPmL
         Q1Vw1omGKNdssgjZmbrQ8chVwI6txgxebaRPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=H5ESpADHxOkFTq8+ykMpZPjfKtu8j8lqUUXveabyobWYjBtFSs4H6Vb0/bvXc68MEE
         hY5lWV0U5SddM4mGI8h2yok2+QFQ3thulEKb1ootVCC+phdyvgyR0P/zAqBgfzmQ3FRQ
         cPzRoWIWX64QS32OTh7ozLz3O5tMSxb5x87+g=
Received: by 10.86.9.17 with SMTP id 17mr4396103fgi.41.1278591589968;
        Thu, 08 Jul 2010 05:19:49 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id x6sm2120465fal.1.2010.07.08.05.19.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 05:19:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100708114125.GA2427@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150568>

On Thu, 8 Jul 2010, Jeff King wrote:
> On Thu, Jul 08, 2010 at 01:00:17PM +0200, Jakub Narebski wrote:
> 
> > Last there is filename munging, done using strip_prefix function.
> > This is done using prefix_length only, and that is the cause of
> > the bug:
> >   $ git diff-tree --abbrev -r --raw HEAD --relative=sub
> >   a3a8425fe5496c61921010cb1e7b455a1f52bb86
> >   :100644 100644 d90bda0... cefcae0... M	/quux
> > 
> > if one uses '--relative=sub' instead of '--relative=sub/'.
> 
> Is that a bug or a feature? You need to say "sub/" to get what you want,
> which is annoying. But it means you can also you "--relative=su" to get
> "b/quux". In that example, it's probably useless, but consider a set of
> filenames "foo-1" through "foo-5". You don't always want to break on a
> directory boundary.
> 
> I believe "git-archive --prefix" has the same behavior for the same
> reason.

Nevertheless for the patch output format both "git diff --relative=sub"
and "git diff --relative=sub/" give the same output, without 'b//quux'.
The same IMHO should be done for raw output format, so we don't have
'/quux' but 'quux'.

-- 
Jakub Narebski
Poland
