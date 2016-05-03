From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v4 09/11] connect: use "-l user" instead of "user@" on
 ssh command line
Date: Wed, 4 May 2016 07:52:48 +0900
Message-ID: <20160503225248.GC21973@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
 <1462265452-32360-10-git-send-email-mh@glandium.org>
 <CAPig+cTTeJf+ACfJ8yDj3tbiwUEhcjgn=MiDkzgDk7sYu4FA+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 04 00:52:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axjBZ-0000L6-W4
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933680AbcECWwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:52:54 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:53094 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932265AbcECWwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:52:53 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1axjBQ-0005ur-DQ; Wed, 04 May 2016 07:52:48 +0900
Content-Disposition: inline
In-Reply-To: <CAPig+cTTeJf+ACfJ8yDj3tbiwUEhcjgn=MiDkzgDk7sYu4FA+w@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293476>

On Tue, May 03, 2016 at 01:33:24PM -0400, Eric Sunshine wrote:
> On Tue, May 3, 2016 at 4:50 AM, Mike Hommey <mh@glandium.org> wrote:
> > While it is not strictly necessary, it makes the connect code simpler
> > when there is user.
> >
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> > diff --git a/connect.c b/connect.c
> > @@ -812,14 +812,10 @@ struct child_process *git_connect(int fd[2], const char *url,
> >                         if (user) {
> > -                               struct strbuf userandhost = STRBUF_INIT;
> > -                               strbuf_addstr(&userandhost, user);
> > -                               strbuf_addch(&userandhost, '@');
> > -                               strbuf_addstr(&userandhost, host);
> > -                               argv_array_push(&conn->args, userandhost.buf);
> > -                               strbuf_release(&userandhost);
> > -                       } else
> > -                               argv_array_push(&conn->args, host);
> > +                               argv_array_push(&conn->args, "-l");
> > +                               argv_array_push(&conn->args, user);
> > +                       }
> > +                       argv_array_push(&conn->args, host);
> 
> Even simpler would be a one-liner for the user case:
> 
>     if (user)
>         argv_array_pushf(&conn->args, "%s@%s"", user, host);

Oh, I should have read the argv-array.h header. Thanks.

Mike
