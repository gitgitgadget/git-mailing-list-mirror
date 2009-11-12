From: Matt Schoen <mtschoen@gmail.com>
Subject: Re: get git not to care about permissions
Date: Thu, 12 Nov 2009 16:44:29 -0500
Message-ID: <3cf217d80911121344w7d1809ebs103eaa2ac19a03a6@mail.gmail.com>
References: <26268938.post@talk.nabble.com>
	 <76718490911112144n6837d02cw94d608bcbc74855a@mail.gmail.com>
	 <3cf217d80911120744g5e020003rc00c460fff0bff1d@mail.gmail.com>
	 <200911121710.44314.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	euguess@gmail.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 12 22:44:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8hT7-0005a7-HM
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 22:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbZKLVoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 16:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbZKLVo3
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 16:44:29 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:50047 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbZKLVo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 16:44:29 -0500
Received: by yxe17 with SMTP id 17so2376548yxe.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 13:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=4ugeqbPlYGPX/hf4nosFc/6jsLdX8wK8uDIvEu3WJUE=;
        b=hxbkZ3qyZ3hlvl1oKBrtIxmn+MVpu610rNGEAc7hXpckuqBNTwgvphnFSU65AhdB9I
         nSzKc5TdV0mIom/4wcI8bqh2oajtpKOsPY4qmljXJAQy9zhge0T72ZT0b19nNGeQ5KkL
         fmcoLqnrOC91jzB9xELaJTa4lPrM5gNbRKcnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ish8n1khnYK72L+NHdVmuZzWVq2kGT9oRIgcyD9jSlu3YAyowf7+P4jygnBMDPtLcZ
         lEHnEJiiJ97vbpo/hmbMYaoH5rUnc+tOpg5JVhGQyeQ75TzNExGBeTrklpMboWfA/54W
         EXebD11cAPF4OMuuLTnWGomIFj5jNhQu6Tzgo=
Received: by 10.101.3.1 with SMTP id f1mr3731281ani.85.1258062269819; Thu, 12 
	Nov 2009 13:44:29 -0800 (PST)
In-Reply-To: <200911121710.44314.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132801>

On Thu, Nov 12, 2009 at 11:10 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> It prints an absolute path, so the open() also accesses an absolute
> path (though I don't know why it insists on that).
>
> But the above directory listing would indicate that you do not even
> have permission to look inside your $(pwd) by absolute path...

I'm pretty sure I can.  How can I test this?  I can ls all
subdirectories within the path, and when I navigate to the path, I
usually do it absolutely.  After all, this is a network share, so I
have to start with "/ad/eng/...".  Although, this is curious.  Some of
the directories show "d---------" when I do ls -al.  They were created
by root in the same environment (forced 700), but I can still read
their contents, and such.

Does open() strictly require the permissions you give it?  Like I
mentioned, the permissions are locked at 700.  Even if I try to chmod
777 the directory, I see no error, but the permissions remain
unchanged.  I'm thinking of doing a custom compile, removing those
places where specific permissions are needed.  My fear is that those
places are many...
