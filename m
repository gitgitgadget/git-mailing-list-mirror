From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 22:33:52 +0530
Message-ID: <CALkWK0k=39-Cq3vNdrpLPTWa0wgkqLM=7c=cAmL0nvx0MT5mkA@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
 <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
 <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
 <20130609151235.GA22905@serenity.lan> <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
 <20130609160225.GB22905@serenity.lan> <CAMP44s0Zsejk4Ex6QfzOFOom3cyWv_hziWGkAK-LawSUkT9V3Q@mail.gmail.com>
 <20130609164248.GD22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:04:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulj2s-0003Ou-S4
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab3FIREl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:04:41 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:51738 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab3FIREd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:04:33 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so5907723ieb.24
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3SCJVnZH5xXyFQgCVR0++f+pH05kvUUXC8XiMbAznRE=;
        b=j0hkRVJXMw0zdWkD77v02bR+9f/Zc+DmjvT38uFDFfQqxBqNyx6je5N/pBAsmPDuGn
         5JQlgeJeE1IcfPDqd7RMbYE7mNtYopp7F44vTd2aoYDaeag3eSXL7af5pqJurSyYqW77
         eGGn+5sGF7VPIEppR5i0QLXcpqrlBRO/CRyxpOELFxquHltjEbImzgq7N4Fg/sxLtD1L
         bTEdu/g7A70sUG96Y2yJJ8sWJR/1GdTxFX3N/FJ1cyehMcg9vJGq4ytEpY1TPUDmRHI8
         QPdBJV3adnlXAK2vDnqta3Y6Y16XYQGy3lHLZ5nCxj2WueAFZTPPyqKXOO6CuPcAWPHA
         tuEw==
X-Received: by 10.50.79.231 with SMTP id m7mr2540170igx.40.1370797472742; Sun,
 09 Jun 2013 10:04:32 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 10:03:52 -0700 (PDT)
In-Reply-To: <20130609164248.GD22905@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227021>

John Keeping wrote:
> Calling across from one builtin/*.c file to another is just as wrong as
> calling into a builtin/*.c file from a top-level file but the build
> system happens not to enforce the former.

So libgit.a is a collection of everything that is shared between
builtins?  Does that correspond to reality?

  $ ls *.h | sed 's/.h$/.c/' | xargs file

An example violation: builtin/log.c uses functions defined in
builtin/shortlog.c.

What is the point of all this separation, if no external scripts are
ever going to use libgit.a?
