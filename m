From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 12:56:21 +0200
Message-ID: <200808221256.21805.jnareb@gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com> <200808221049.21337.jnareb@gmail.com> <cb7bb73a0808220231w37d2341eic56cabb595399f68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 12:57:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWUKj-0003xL-S9
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 12:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYHVK4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 06:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbYHVK4a
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 06:56:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:6596 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbYHVK43 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 06:56:29 -0400
Received: by nf-out-0910.google.com with SMTP id d3so187407nfc.21
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KLRbnonGVGMA7MY/PX/imkkzgUx1fAqhddFDvp8QSEk=;
        b=Uy3Q6edJYCO4nBzZqWfzj2yO8Lg0doADlc9Y/Xs/uLvSb7OvNL1XgdqnW7phQufsum
         jjNl4+YtcMWUaLBiFzPOZOZHe0GBCjvtCPzeFLQSt0U17pKkYMlxHTrXYzFysJiK7x/k
         g7ZAaSHqbx4U7s/aQnxDSGhVnJ/6Ie2GbxWxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZKd1A+zZUM+v8mNrl8OxYWgtIYF3r6TYGTO372dNQ7Kb5okbsv5nZxz5YMl9rTzPlP
         JCYh0KNhq7L8MTvDIY+WMns4nyX+DaxBdNQWoLqmcyIa9i05RjMF+dBPW6tpRN7mlWxp
         fRt/CBNjNZpzeIw2YyL+r5YqZ/rinTG8wqmh8=
Received: by 10.210.66.13 with SMTP id o13mr1259190eba.193.1219402586627;
        Fri, 22 Aug 2008 03:56:26 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.249.91])
        by mx.google.com with ESMTPS id 10sm1207473eyd.6.2008.08.22.03.56.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 03:56:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0808220231w37d2341eic56cabb595399f68@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93281>

On Fri, 22 August 2008, Giuseppe Bilotta wrote:
> On Fri, Aug 22, 2008 at 10:49 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > What format_ref_marker() uses is not exactly 'type' of reference, but
> > more 'kind of' reference.  It is based on reference namespace, not
> > on type of object the reference is at (points to).  So code based
> > on this info (like your v3 patch) would fail on lightweight tag, i.e.
> > if there is ref in 'refs/tags' namespace which points directly to commit,
> > and not to tag object.
> >
> > But 'git show-ref --dereference' _has_ information about whether
> > given reference points directly or indirectly to given object
> > ($refs->{$id}), but currently we neither save it, nor use it.
> > For example we can have:
> >
> >  781c1834f5419bdf81bb7f3750170ccd6b809174 refs/heads/maint
> >  ...
> >  124c62e8781a8f03ee0256bee78f7b392e3920af refs/stash
> >  ...
> >  89e6fcde639d65823e8113c307067441701ac74f refs/tags/Attic/gitweb/parse_rev_list
> >  b69a41a384d19fe253b9f4f34c9019ad96ca571d refs/tags/Attic/gitweb/patchset_body
> >  781c1834f5419bdf81bb7f3750170ccd6b809174 refs/tags/TEMP
> >  ...
> >  07cca3b30ee2b5d060e44e5b18d7c22929c63d1a refs/tags/v1.5.6.5
> >  781c1834f5419bdf81bb7f3750170ccd6b809174 refs/tags/v1.5.6.5^{}
> >
> > Now in this example we have three refs pointing to commit object
> > 781c1834: refs/heads/maint, refs/tags/TEMP and refs/tags/v1.5.6.5.
> > From those only refs/tags/v1.5.6.5 is (via) tag, even though TEMP
> > is in tags namespace.  Currently git_get_references() strips '^{}'
> > indirect reference marker from the output (from refname), and doesn't
> > make use of it.  One solution would be to not stip it in
> > git_get_references(), but leave it, and strip it and make use of
> > it (if ref ends with '^{}' it must be tag object) in format_ref_marker().
> 
> Ah, I see what you mean. If I understand correctly, this particular
> situation is only a problem with tags, as they can be either
> lighweight tags (that reference a commit) or actual tag objects (that
> are indirect references to commits and direct references to
> themselves), whereas everything else is just direct references to
> object.

Yes, properly managed git repository should have refs pointing to
tag objects only in 'refs/tags' (tags) namespace.

> Handling this requires a couple of extra info to be carried 
> over in $refs, so I guess I'll have to experiment with it  a little
> since it would require a more extensive change than I originally
> planned.

This "couple of extra info" could be just '^{}' suffix.  So I don't
think it would be very complicated.

You could simply do not strip '^{}' suffix in git_get_references()
subroutine (so for example $refs->{$id} could be "tags/v1.6.0^{}",
and not simply "tags/v1.6.0" when $id is sha-1 of a _commit_ indirectly
referenced by v1.6.0, i.e. referenced by v1.6.0 _tag_), and strip
it and make use of it in format_ref_marker():

   if ($ref =~ s/\^\{\}$//) {
      # $ref is a tag
   } else {
      # $ref points directly to object
   }

HTH.

P.S. I have re-added git mailing list to Cc:.
-- 
Jakub Narebski
Poland
