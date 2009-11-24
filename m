From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-subtree: directory mismatch
Date: Tue, 24 Nov 2009 16:48:26 -0500
Message-ID: <32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Fournier <marc.fournier@camptocamp.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 22:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND3Fm-0006Tw-Hk
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 22:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934203AbZKXVsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 16:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933968AbZKXVsl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 16:48:41 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:50984 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933899AbZKXVsk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2009 16:48:40 -0500
Received: by gxk26 with SMTP id 26so7134350gxk.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 13:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=e7YaXY3xIi+cpkBIDO2xcl+mJh/UjjX7KY60WjhG4XA=;
        b=dEyLdRJduYEJ5qZl5ujb7rZxPmChwgNDxYV6lOntkxS0rP1DG2ZMYsm7rzDziHKd7n
         JZRawWjsf5Bb1a5EN0ZjtqI3Ku24YlPz5bAYBbW6Au9spJGJnUAKds7O8JBFgDeo7+d8
         X8xmwFwKIU8XZJIU6aRHG0pCfntHqCqVyKGJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HxukMkxO01uCQ8umpFWjjmEL5nYJFctaqsir6A3pp/h7G+Nb5SUOy+ADtLuR50+jXz
         LMnUgCybs5mP3XULss+/Z7SHPUMtTG9jVB6fapSj7ElA7+wAaqHB53mqKMj7lxUD7Sxq
         s3cJsfJLWeC34k0fYKMtFTTT2iDw5mUny8/QY=
Received: by 10.150.130.24 with SMTP id c24mr12157732ybd.168.1259099327101; 
	Tue, 24 Nov 2009 13:48:47 -0800 (PST)
In-Reply-To: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133594>

On Tue, Nov 24, 2009 at 2:53 PM, Marc Fournier
<marc.fournier@camptocamp.com> wrote:
> I was not able to reproduce this bug in any of the following cases:
> =A0- if the README file wasn't empty
> =A0- if modules/cognac is renamed to something else
> =A0- if modules/cognac doesn't have the same sub-directories than
> =A0 modules/mapserver
>
> This bug happens using git 1.5.5.6 as well as 1.6.5. It seems to happ=
en
> when git-subtree calls "git merge -s subtree".

Yup.  This is basically a bug in "git merge -s subtree": it guesses
which subtree to merge into, rather than actually taking a prefix
parameter.  I've been meaning to either submit a patch for this, or
find a way to work around it.

This doesn't usually happen once your project is relatively mature
(ie. doesn't have blank or "default" template files in it) since then
the auto-guessing gets more reliable.  But there's no good reason to
do the auto-guessing, so it would be best to do this "properly."

Sorry that I haven't had time to fix it yet...

Avery
