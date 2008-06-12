From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Wed, 11 Jun 2008 18:31:28 -0700
Message-ID: <48507C70.8010402@gnu.org>
References: <20080612002258.GC7200@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 03:32:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6bg0-000241-To
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 03:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531AbYFLBbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 21:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbYFLBbg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 21:31:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:39203 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522AbYFLBbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 21:31:35 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2709429waf.23
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 18:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=Q/loftlIUKUivonTfLatxEBR4I6QrYueg8OMM4hFuJs=;
        b=xTmEg+W61A1f7jcmzNM0IJMxhaOLi8x1i93MJYcHEXSjEwcpzv0t2lrlm/DX2OX1Ch
         v99bDh7cQMOoFM+d9/zSM3a7/JBdMe+4/Sj+JgrEuQnGIKxiA0ef8mgkqaivjy5wC7hL
         RCvUg1NZRho3feQxGY2Y+XQWhsAyYnaQEX5Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=YCakjc8KE0LkUY+TRkNgi67dCBFRx6Tw5dLfogq7c3qEDAokqxjnVUKtxa9SWzavOq
         D9RVp+7vzvNdNb5pdAnTWu3iTVksNXMtQg3kzW/H6FM3ckgVeJXUvWmJSgVubXzkoef4
         tGAzvN8+Ur4VGkQrfkxPHN1iXu/VVPQBbOgLI=
Received: by 10.115.14.1 with SMTP id r1mr751312wai.139.1213234294989;
        Wed, 11 Jun 2008 18:31:34 -0700 (PDT)
Received: from scientist-2.local ( [65.248.49.163])
        by mx.google.com with ESMTPS id n20sm1038835pof.0.2008.06.11.18.31.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jun 2008 18:31:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <20080612002258.GC7200@leksak.fem-net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84691>


> 	--collect-signoffs;;
> 		Collect the Signed-by-off: lines of each commit and
> 		add them to the squashed commit message.

I think this makes sense only if -m/-F/-C/-c (see later) is used, 
because otherwise the default behavior would be to concatenate all 
messages and call the editor, right?  Would it be a no-op if those 
options are not given?

> tag <tag>::
> 	Set tag `<tag>` to the current HEAD,
> 	see also linkgit:git-tag[1].
> 	If another commit is tagged `<tag>`, it will lose this tag,
> 	i.e. the tag will be reset to HEAD.

Is this a lightweight or a heavyweight tag?  I guess lightweight -- the 
tag command should probably support -a, -s and -u like git-tag does. 
Unless -c/-C/-F/-m is given, the sequencer will then run the editor.

> -C <commit-ish>::
> --reuse-commit=<commit-ish>::
> --reference=<commit-ish>::
> 	Reuse message and authorship data from specified commit.

Why --reference?  Also,

> -M <commit-ish>
> --reuse-message=<commit-ish>::
> 	Reuse message from specified commit.
> 	Note, that only the commit message is reused
> 	and not the authorship information.

For consistency with git-commit I would think it's better to have

   -c <commit-ish>::
   -C <commit-ish>::
   --reedit-message=<commit-ish>::
   --reuse-message=<commit-ish>::
	Take existing commit object, and reuse the log message and the
         authorship information (including the timestamp) when creating
         the commit. With -C (or --reuse-message), the editor is not
	invoked; with -c (or --reedit-message) the user can further edit
	the commit message.

(I know it's confusing that it's reusing the message too, but...) and 
then a separate option:

   -A
   --author-override::
	Force authorship information for commits created by the command
	to be the data in git's configuration files.

... if it is not too complicated to implement.

To satisfy Pierre's comment, you might also add a "-e" general option, 
which forces an invocation of the editor -- even if -C/-m/-F are given, 
and even if the command is pick/patch/merge.  I guess that in order to 
support -C/-m/-F you already have to use git-cherry-pick and git-merge's 
--no-commit options, so it should not be hard to implement.

Paolo
