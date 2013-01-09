From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: On --depth=funny value
Date: Wed, 9 Jan 2013 21:59:56 +0700
Message-ID: <CACsJy8Cp-2gRhdU+V8H7+FeWZXfptJLbzw1swxdks61fO+73NQ@mail.gmail.com>
References: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
 <CACsJy8BLLTWd+cTBj1jNW=ODPy7=Kg4-TPUdZ82YCE-0RQpMZA@mail.gmail.com> <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 16:00:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsx95-0004aW-FH
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 16:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972Ab3AIPA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 10:00:27 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:63805 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339Ab3AIPA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 10:00:26 -0500
Received: by mail-oa0-f48.google.com with SMTP id h2so1076183oag.21
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 07:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=a+JEiGpUgWTuPqGwL5XAwtymlGZbU3wELJW0c12xuYc=;
        b=yvOwJ4sr/diak0x4+LM1W28rAaGdxRDnnnp+VuYu0EMB7VY8F61eDL50HPQOSOWbE2
         Ox6z6UaXFgjMDbUJxHu7r+YAcTEHAR9tKWCSg6RF6F8EMVHmdj+h2slwHTSnNRoNoczu
         3oXyv7I6te/7qlG9FT0yjon1AOmz1T+ocyE+u/gJgRxidCcYYmz8k3SvkMoOnswgNpkf
         yzxlTQUHDJxNzYhKDk86nwm33gmge8/eru4IyBveCItPgCcKPSa3A7W2ODeNNYthY4H7
         MlCKwMJnU2ebur7z0k8KhHAJR/+7ANOAmcBCIIL9QMjxnM4tHcvMIIPN4cINsqLLZGwT
         ootQ==
Received: by 10.60.8.131 with SMTP id r3mr38101161oea.14.1357743626477; Wed,
 09 Jan 2013 07:00:26 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Wed, 9 Jan 2013 06:59:56 -0800 (PST)
In-Reply-To: <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213059>

On Wed, Jan 9, 2013 at 9:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  * Make "git fetch" and "git clone" die() when zero or negative
>    number is given with --depth=$N, for the following reasons:
>    ...

For Stefan when you update the patch. If "git fetch --depth=0" is
considered invalid too as Junio outlined, then the proper place for
the check is transport.c:set_git_option(), not clone.c. It already
catches --depth=random-string. Adding "depth < 1" check should be
trivial. You may want to update builtin/fetch-pack.c too because it
does not share this code.
-- 
Duy
