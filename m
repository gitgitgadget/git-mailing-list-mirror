From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Tue, 22 Jan 2013 08:10:34 +0700
Message-ID: <CACsJy8B1=3gMfGUf3kyea9TyZmr1J7dbM1_+huMNrep24hwuiQ@mail.gmail.com>
References: <7v1udfn0tm.fsf@alter.siamese.dyndns.org> <1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:11:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxSOd-0004vv-UL
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 02:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab3AVBLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 20:11:06 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:56184 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3AVBLF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 20:11:05 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so6497971obb.21
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 17:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ol3UJaQqxz+aFEGxuKLKac5FEwNnx0LBazSCBLZHh7c=;
        b=nko8QfkuN6a+AWfblsxehJdWPkHlnBi69EweTtTVTvCFYZ82sMeaLceMIdOQjiIRzw
         HkNcP41TgcAgdiEMpSCKKbKy0e+LRpIKdIwTIm4akshuAWOh8SNyPocz9q8+wIX6IuyS
         QET0vh6wCWucsQHd3yfO0AZdyeYb3OaXiZXXpbOpJFBO80icedg+BkgQ7AnqAUSDDJdj
         SmnRW4IK3f5Z05hG+TPmrfwdOnq+4rbK4DkjZaW2g+SQ2JYLaKfNzuOmgeKq1X4o96mK
         9O4onyZyKTZ1H4Un+LtzqtbHu+JXIQcoLoGLiv2CPqnIdvX+fL7l2S5ljVbqd98Q3qMz
         iRXA==
X-Received: by 10.182.131.3 with SMTP id oi3mr15231539obb.84.1358817064340;
 Mon, 21 Jan 2013 17:11:04 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Mon, 21 Jan 2013 17:10:34 -0800 (PST)
In-Reply-To: <1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214184>

On Mon, Jan 21, 2013 at 7:00 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Most git commands that can be used with our without a filepattern are
> tree-wide by default, the filepattern being used to restrict their scope.
> A few exceptions are: 'git grep', 'git clean', 'git add -u' and 'git add -A'.
>
> The inconsistancy of 'git add -u' and 'git add -A' are particularly
> problematic since other 'git add' subcommands (namely 'git add -p' and
> 'git add -e') are tree-wide by default.
>
> Flipping the default now is unacceptable, so this patch starts training
> users to type explicitely 'git add -u|-A :/' or 'git add -u|-A .', to prepare
> for the next steps:
>
> * forbid 'git add -u|-A' without filepattern (like 'git add' without
>   option)
>
> * much later, maybe, re-allow 'git add -u|-A' without filepattern, with a
>   tree-wide scope.

What about 'grep' and 'clean'? I think at least 'clean' should go
tree-wide default too. I don't mind grep go the same way either but I
think people voiced preference in current behavior..
-- 
Duy
