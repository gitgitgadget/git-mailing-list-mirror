From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Segfault in git reflog
Date: Wed, 30 Dec 2015 20:19:14 +0700
Message-ID: <20151230131914.GA27241@lanh>
References: <20151230092400.GA9319@spirit>
 <1451474248.9251.7.camel@kaarsemaker.net>
 <CACsJy8CoRs8dNPWag-E947oVTt4R8XbKBLvaQvBPGm4jqZBKNw@mail.gmail.com>
 <CACsJy8Cm6a2FiyZwXsTpzbp7ZkZUGWf=HmjsMtQvJMjzVLkTzA@mail.gmail.com>
 <1451478486.9251.11.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 14:19:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEGez-0002uq-PV
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 14:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbbL3NTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 08:19:22 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33894 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbbL3NTV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 08:19:21 -0500
Received: by mail-pa0-f44.google.com with SMTP id uo6so116931737pac.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 05:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CvoyRe99LxAn2YNljby3SCn4eQYJJuc1VVBEwNyCdZE=;
        b=VwmZ04rF9urd5JDQCiuoGW+Qawmvq6nBW+OKPdc8feXAuwZ/I9Jlopj+5q8gAmXqrY
         eZgsFV1VYIIRjncK+/u0plIUjCDHgRAchqNkJhpSV5bthdQH9BTJRvUNoioiDlrdOG7H
         SShu2bJyeQmAJV8wgeHC7LoALnAV+N0jRpUvdQ4YW5kZEA6Ww/7/tFjFnrLDWx0zRhn3
         m4z+XMKcEMJmbchzgFEFRZhzIBYnsHZxiF5w0KCHo98OB/bLHNclFuB+EAb9gLCHf5gf
         H+N3uyrXZ73hdNbzj53T/oB5eeA5rNlyalufck0QDgdam5Ss65CNEFuZ65ut5mFgJNGB
         Tqhg==
X-Received: by 10.66.252.6 with SMTP id zo6mr27087203pac.154.1451481560782;
        Wed, 30 Dec 2015 05:19:20 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id r193sm90196180pfr.65.2015.12.30.05.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 05:19:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 30 Dec 2015 20:19:14 +0700
Content-Disposition: inline
In-Reply-To: <1451478486.9251.11.camel@kaarsemaker.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283181>

On Wed, Dec 30, 2015 at 01:28:06PM +0100, Dennis Kaarsemaker wrote:
> On wo, 2015-12-30 at 18:28 +0700, Duy Nguyen wrote:
> > On Wed, Dec 30, 2015 at 6:26 PM, Duy Nguyen <pclouds@gmail.com>
> > wrote:
> > > On Wed, Dec 30, 2015 at 6:17 PM, Dennis Kaarsemaker
> > > <dennis@kaarsemaker.net> wrote:
> > >> On wo, 2015-12-30 at 10:24 +0100, Dennis Kaarsemaker wrote:
> > >>> spirit:~/code/git (master)$ cat .git/logs/HEAD
> > >>> 2635c2b8bfc9aec07b7f023d8e3b3d02df715344
> > 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <
> > dennis@kaarsemaker.net> 1446765642 +0100
> > >>> 74c855f87d25a5b5c12d0485ec77c785a1c734c5
> > 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <
> > dennis@kaarsemaker.net> 1446765951 +0100  checkout: moving from
> > 3c3d3f629a6176b401ebec455c5dd59ed1b5f910 to master
> > 
> > Ah... I came from a different angle and did not realize the tag sha1
> > is from your reflog. So yeah maybe reflog parsing code should check
> > object type first, don't assume it's a commit!
> 
> Something like this perhaps?
> 
> diff --git a/reflog-walk.c b/reflog-walk.c
> index 85b8a54..cd538dd 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -25,6 +25,14 @@ static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
>  {
>         struct complete_reflogs *array = cb_data;
>         struct reflog_info *item;
> +       struct object *obj;
> +
> +       obj = parse_object(osha1);
> +       if(obj && obj->type != OBJ_COMMIT)
> +               die(_("Broken reflog, %s is a %s, not a commit"), sha1_to_hex(obj->oid.hash), typename(obj->type));
> +       obj = parse_object(nsha1);
> +       if(obj && obj->type != OBJ_COMMIT)
> +               die(_("Broken reflog, %s is a %s, not a commit"), sha1_to_hex(obj->oid.hash), typename(obj->type));
>  
>         ALLOC_GROW(array->items, array->nr + 1, array->alloc);
>         item = array->items + array->nr;
> 
> That gives me:
> fatal: Broken reflog, 74c855f87d25a5b5c12d0485ec77c785a1c734c5 is a tag, not a commit

I would go with something like this. The typecasting to "struct commit
*" is the bug because parse_object() can return any object type. With
this I got

error: object 74c855f87d25a5b5c12d0485ec77c785a1c734c5 is a tag, not a commit

diff --git a/reflog-walk.c b/reflog-walk.c
index 85b8a54..09d18fa 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -236,8 +236,9 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 	info->last_commit_reflog = commit_reflog;
 	commit_reflog->recno--;
-	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
-	if (!commit_info->commit) {
+	commit_info->commit = lookup_commit(reflog->osha1);
+	if (!commit_info->commit ||
+	    parse_commit(commit_info->commit)) {
 		commit->parents = NULL;
 		return;
 	}
--
Duy
