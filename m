From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git init with template dir
Date: Fri, 12 Jun 2015 08:27:24 -0700
Message-ID: <xmqqioatdk0z.fsf@gitster.dls.corp.google.com>
References: <loom.20150612T085835-977@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alex Cornejo <acornejo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 17:27:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Qrk-0001T5-Tc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 17:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbbFLP12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 11:27:28 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36588 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbFLP11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 11:27:27 -0400
Received: by igbpi8 with SMTP id pi8so14265418igb.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Wy/lD1kpEahqb4cmYa/BgDlWCsXDWPsJ7PaTFRu0fKY=;
        b=Hh3SFlG/IVJRRL4+zE5IDyGy2jNrCDUccGV6iFz4v/LsVvA2kidsia4/cpSwjPyPM8
         ScPeHN1kKDuy+up8mFF1jJI+DNdUM50L0PKAzFRPNy4V1hANK6Lcum2KMYC70vhkVnT/
         wFIXBQTCKVdU7vZ4zU18C1vBi+mOI0diBZ3Pw5UO/RKMUVBOI5mCJ0WUjVJ+VvJ5aK4G
         kc6+ULz7d0pB76Zcw7Iiso+UJHBC1LWh608RP7ubKjD7wYfUnDh4DthNVSUhOaYNpJPR
         DwDHP0y6tNGzERWA+lAOkLLAXkJs4SxQEw0VVjdxzE5VNhuw4QA7+u86DtxUc4IRp5Nc
         e9Pw==
X-Received: by 10.107.132.138 with SMTP id o10mr19043619ioi.52.1434122846711;
        Fri, 12 Jun 2015 08:27:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac40:153c:ed59:12ce])
        by mx.google.com with ESMTPSA id rt5sm1375898igb.8.2015.06.12.08.27.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 08:27:26 -0700 (PDT)
In-Reply-To: <loom.20150612T085835-977@post.gmane.org> (Alex Cornejo's message
	of "Fri, 12 Jun 2015 07:09:18 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271492>

Alex Cornejo <acornejo@gmail.com> writes:

> I was surprised to see that when using git-init, if the template folder
> is itself a symlink, then the contents of the template is NOT copied to
> the resulting git repository, but instead each individual file is
> symlinked.

Hmmm, I do not seem to be able to do this, though.

        $ ln -s $HOME/g/share/git-core/templates /var/tmp/git-template
        $ cd /var/tmp
	$ git init --template=/var/tmp/git-template new
        $ find new/.git -type l
        ... nothing ...

> For my particular use case, this is undesirable (since if I am not
> careful, then when I change the hook of one git repo, it
> actually changes the hooks of all other repos too). It is easy
> enough for me to work around this (i.e. by instead pointing my gitconfig
> to use a template dir which is not a symlink), but I was
> wondering weather this is a feature folks use (and for what end), or if
> this is unintended behavior.

That you had to predicate "this is undesireable" with "For my
particular use case" tells me that other people may want to see that
these things shared and automatically receive updates when the
originals in the temporate directory are updated, which makes it
sound like a "feature" not an "unintended behaviour", at least to
me.
