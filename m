From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] git checkout $tree path
Date: Tue, 4 Oct 2011 11:05:11 -0400
Message-ID: <CAG+J_Dy7gnDEK-9KAJT4M_wumS_QpzLNMVzAiOHCyEbFBU65=w@mail.gmail.com>
References: <7vk48rq854.fsf@alter.siamese.dyndns.org>
	<20111003102647.GD16078@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 17:05:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB6Yb-0007SR-Ly
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 17:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471Ab1JDPFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 11:05:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42793 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463Ab1JDPFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 11:05:13 -0400
Received: by gyg10 with SMTP id 10so564990gyg.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z6MqAYFX68iWbUGHmjHdyzhPiYphwLK+mCdi/f6R5s8=;
        b=DISrok6dO1oe4OGfUqb+t4Zd3O6MFCi3ULOy+IpYasgUBO8r03br/j/mOzxnpIZmQY
         UDqfaJlYcrkE531iz/Gs57DkaTwp51f7+Nx/yy9KQRVYCWFhrR7RzYJCU0AqscDMzJuo
         c/cNly1jE4DXn+hDMUNwzsBNFISTwD2fMDDjU=
Received: by 10.236.190.200 with SMTP id e48mr7177472yhn.59.1317740712015;
 Tue, 04 Oct 2011 08:05:12 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Tue, 4 Oct 2011 08:05:11 -0700 (PDT)
In-Reply-To: <20111003102647.GD16078@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182773>

On Mon, Oct 3, 2011 at 6:26 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 29, 2011 at 03:46:31PM -0700, Junio C Hamano wrote:
>> An alternative semantics could be to first remove paths that match the
>> given pathspec from the index, then update the index with paths taken from
>> the named tree, and update the working tree. "git checkout master dir"
>> would then mean "replace anything currently in dir with whatever is in dir
>> in master". It is more dangerous, and it can easily emulated by doing:
>
> being what the user expects. As in, "master deleted this file; shouldn't
> checkout pull the deletion to my new branch when I ask it to?".
>
> But we can't distinguish those two cases without actually having a merge
> base. And this isn't a merge; it's not about picking changes from
> master, it's about saying "make dir look like it does in master". So
> in that sense, the most straightforward thing is your second
> alternative: afterwards, we should have only the files in "dir" that
> master has.

I think I'd expect the first behavior with:

$ git checkout master -- dir/*

And the second with:

$ git checkout master -- dir

$0.02.

j.
