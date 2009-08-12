From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git index: how does it work?
Date: Wed, 12 Aug 2009 10:47:47 -0700
Message-ID: <fabb9a1e0908121047jf7e6cf1n757cde626c79830c@mail.gmail.com>
References: <loom.20090805T160528-69@post.gmane.org> <7v7hxi9m4k.fsf@alter.siamese.dyndns.org> 
	<436D5ED1-2F0E-4227-AC4A-3A5FD16B2DCF@cuttshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shaun Cutts <shaun@cuttshome.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 19:48:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbHvu-0005qI-H6
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 19:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbZHLRsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 13:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbZHLRsI
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 13:48:08 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:62797 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbZHLRsH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 13:48:07 -0400
Received: by ewy10 with SMTP id 10so198583ewy.37
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=o9+1dSB7obCiaVdeO/nxFzCFPIW2VG4R7dc6CYRVAjI=;
        b=KLLZzrO3AGqMXlUhXCfuu4BBu3cvKqoqQWCFlJ0nHpnN5sAw9wMhJWFxFtN7EveIB5
         0CheETl77xXhnu0zmMQOX72PPmhD4iql64zyad3UzjAk1r9qAOWBXnqmtevGNMZyfRdT
         yxgBZkDQyRfTXT4nOVbb6RuvXUYiYqHrdEXvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Syl2phOJqFT+2L9gS83tWpAY1iUiJlgqPnZC1x5AJdUgbMYLWNuzeEtUupTfOj/5UA
         oI9dTmd/X9KgBvXjJqiNqsiierdnahm6subOohIFRQadENQg41h3kJXB9UNZ6Rmoqttd
         bB68gEAAlj/VLEQ0bkcDpbQ+aYjGhg4blevEw=
Received: by 10.216.47.196 with SMTP id t46mr53188web.121.1250099287092; Wed, 
	12 Aug 2009 10:48:07 -0700 (PDT)
In-Reply-To: <436D5ED1-2F0E-4227-AC4A-3A5FD16B2DCF@cuttshome.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125720>

Heya,

On Wed, Aug 12, 2009 at 04:52, Shaun Cutts<shaun@cuttshome.net> wrote:
> Are renames being tracked by the index, and is there a more basic interface
> than "status" to query about them?

Nope, git never explicitly tracks renames. Try this:
$ mv foo bar
$ git rm --cached foo
$ git add bar
$ git status

It'll tell you that you renamed foo to bar, even if you never executed 'git mv'.

This is because git does rename _detection_, that is, it'll notice
that you have another file with (almost) the same contents, so it
assumes you did a rename.

-- 
Cheers,

Sverre Rabbelier
