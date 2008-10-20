From: Baz <brian.ewins@gmail.com>
Subject: Re: need help stripping a repo to one file
Date: Mon, 20 Oct 2008 12:53:04 +0100
Message-ID: <2faad3050810200453o231d9702i6856657b925dd332@mail.gmail.com>
References: <81bfc67a0810190327i7842d346g4c20f5816e8a9eda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Caleb Cushing" <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 20:10:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrtL4-00062X-Cf
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 13:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYJTLxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 07:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYJTLxI
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 07:53:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:51673 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbYJTLxG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 07:53:06 -0400
Received: by nf-out-0910.google.com with SMTP id d3so889657nfc.21
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 04:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MFISBb64uZoo/rqaqz5yDKzYZ2ZqW0zf2wZQpt74Ymw=;
        b=ji1xubpyFo3xubSvyW458kO56tGrktf6eppiIuGyR6STXiyYq3ZqDSopahxthJYabN
         Y40DcBZ7tGNxXTOY52ADNBMERhNukEvfkz9kM/aW3GnCpkIYplprImzKpTpqO3ZoGAux
         zYlF9ZT5ZppIWM6DIik1w8V/5TDwayBFNyc3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VyQ+CZKl3AfQMIeNLf71zNOU4g8+PLscWKnYjlFMYbXgfTmF5ZFJQnTGUIX3grC744
         9yTs6X78N3Jgck6EBwH5fwlXNHCrFmMy7gV+F68mWEArcSQB4G22xOHbo2RJOxHoutFd
         N5fcvoBAGZ8UrQ4WnZGTCrdZh0sg56iOLZpIY=
Received: by 10.103.249.19 with SMTP id b19mr458026mus.53.1224503584696;
        Mon, 20 Oct 2008 04:53:04 -0700 (PDT)
Received: by 10.103.141.13 with HTTP; Mon, 20 Oct 2008 04:53:04 -0700 (PDT)
In-Reply-To: <81bfc67a0810190327i7842d346g4c20f5816e8a9eda@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98685>

2008/10/19 Caleb Cushing <xenoterracide@gmail.com>:
> here's what I've done so far (note: this is a public repo if anyone
> wants to take a look)
>
> git clone git@github.com:xenoterracide/dot_usr.git sql_iabbr
> cd sql_iabbr/
> git checkout db3c5ffb180f10dde8e539a81a6644760e098dcd
> git branch -D master
> git checkout -b master
> git filter-branch --subdirectory-filter  vim/ftplugin/ -- --all
>
>
> that leaves me with this
> html  sgml  sh  tex  vim  xhtml  xml  sql_iabbr.vim  xml.vim
>
> all I want left is sql_iabbr.vim and it's history

So you just want the history for a single file?

 git log -p --reverse --pretty=email -- sql_iabbr.vim

That outputs a patch history for sql_iabbr.vim in mbox format, you can
import that into an empty repo with git-am.

(I had a look at the project, the history is simple with no merges
etc, so nothing like --first-parent is needed)

Cheers,
Baz

>
> I've used stuff like
> git filter-branch --tree-filter 'rm -rf xml.vim' HEAD
>
> to remove the files... but I notice that leaves the logs.
>
> I'm thinking I could do that and then remove those commits but I
> haven't figured out how to remove the commits, and even then I'm not
> sure the repo would be in the state I want.
>
> can anyone help me get to where I want to be? also is there an easier
> way to do what I've done so far?
> --
> Caleb Cushing
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
