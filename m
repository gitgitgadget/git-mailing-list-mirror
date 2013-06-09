From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 17:42:49 +0100
Message-ID: <20130609164248.GD22905@serenity.lan>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
 <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
 <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
 <20130609151235.GA22905@serenity.lan>
 <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
 <20130609160225.GB22905@serenity.lan>
 <CAMP44s0Zsejk4Ex6QfzOFOom3cyWv_hziWGkAK-LawSUkT9V3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 18:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlikQ-00087f-9B
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217Ab3FIQnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:08 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:42595 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3FIQnE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 467D8CDA2D4;
	Sun,  9 Jun 2013 17:43:04 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1PFtluJk1APA; Sun,  9 Jun 2013 17:43:03 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id CE82FCDA596;
	Sun,  9 Jun 2013 17:43:02 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id B7E20161E48C;
	Sun,  9 Jun 2013 17:43:02 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NbUjzYdSYtYT; Sun,  9 Jun 2013 17:43:01 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 5BDFF161E450;
	Sun,  9 Jun 2013 17:42:50 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0Zsejk4Ex6QfzOFOom3cyWv_hziWGkAK-LawSUkT9V3Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227017>

On Sun, Jun 09, 2013 at 11:22:06AM -0500, Felipe Contreras wrote:
> On Sun, Jun 9, 2013 at 11:02 AM, John Keeping <john@keeping.me.uk> wrote:
> > But we make a distinction between things that are specific to one
> > command (especially argument parsing and user interaction) and more
> > generally useful features.
> 
> No, we don't. Everything under ./*.o goes to libgit.a, and everything
> under ./builtin/*.o goes to 'git'. So builtin/commit.o can access code
> from builtin/notes.o, but sequencer.o can't.

I would argue that it was a mistake not to extract these functions from
builtin/notes.c to notes.c when builtin/commit.c started using them.
Calling across from one builtin/*.c file to another is just as wrong as
calling into a builtin/*.c file from a top-level file but the build
system happens not to enforce the former.
