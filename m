From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 3/5] Add stack creation and initialisation support to lib.Stack
Date: Sun, 8 Jun 2008 23:03:15 +0100
Message-ID: <b0943d9e0806081503s1c25b2f3gbf68380c042d1cb0@mail.gmail.com>
References: <20080606204322.8805.32313.stgit@localhost.localdomain>
	 <20080606204554.8805.37257.stgit@localhost.localdomain>
	 <20080607093051.GE32647@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 00:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Szs-0005za-Nj
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 00:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620AbYFHWDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 18:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756511AbYFHWDR
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 18:03:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:6049 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574AbYFHWDP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jun 2008 18:03:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so42503rvb.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=C1s4S9zA+4qnpFjzUpkEjxpXWr10kTi0F3/x3Y3Kyfo=;
        b=EyPsS18TqLqYbiSVgAniGQqUJ3XKHcnlMDMiVzzpqr+uFhbi225BcWvxCWtQEY3iLt
         BbbdBNqfZxay/JOR41nZzMwiA7D2l9qIsrfOlYQBdQ62EE1GKPR3EigF7qJ+9/rymhrs
         cZ17uPxF/kM0ZNCiw3UdP58MnSyvN9q9HWFkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IGZJKeZF/oHZ4bUjch7L/HB2h4OpZAR73RvXXzkSGBhWQlIVfU80Hq/+PQWVHu4CFA
         6ejXm5k21Hz0RydJrnns1r5NbtVUcbveD9ApGE85CYep90fCpgX5P6Q8bMcA3tYEOWYT
         p+tlxYAkq5G9OuwmIzxe9gbUaW/F6e1izAmGI=
Received: by 10.114.169.2 with SMTP id r2mr2543733wae.132.1212962595237;
        Sun, 08 Jun 2008 15:03:15 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Sun, 8 Jun 2008 15:03:15 -0700 (PDT)
In-Reply-To: <20080607093051.GE32647@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84333>

On 07/06/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-06-06 21:45:54 +0100, Catalin Marinas wrote:
>  > +    @staticmethod
>  > +    def create(stackdir):
>  > +        """Create the PatchOrder specific files
>  > +        """
>  > +        utils.create_empty_file(os.path.join(stackdir, 'applied')=
)
>  > +        utils.create_empty_file(os.path.join(stackdir, 'unapplied=
'))
>  > +        utils.create_empty_file(os.path.join(stackdir, 'hidden'))
>
>
> Maybe s/create/create_files/ or soething to that effect here, as I
>  suggested in another mail a few minutes ago.

Done, no problem with that.

>  > +    def set_parents(self, remote, branch):
>  > +        if remote:
>  > +            self.set_parent_remote(remote)
>  > +        if branch:
>  > +            self.set_parent_branch(branch)
>
>
> Much clearer now. Interesting that the only reason we need this
>  function at all is to make sure that set_parent_remote and
>  set_parent_branch are called in the correct order.
>
>  Maybe set_parent_branch should throw an exception instead of silentl=
y
>  doing nothing when there is no parent yet? It would force the caller=
s
>  to be more aware of the limitation -- though we might not actually
>  want that. Your call.

I can't argue much. I propose to commit the patch as is and modify it
afterwards. I haven't touched this code much, it was Yann's
implementation and I forgot all the decisions at that time.

--=20
Catalin
