From: David Turner <dturner@twopensource.com>
Subject: Re: git fsck exit code?
Date: Fri, 29 Aug 2014 16:18:00 -0400
Organization: Twitter
Message-ID: <1409343480.19256.2.camel@leckie>
References: <1409177412.15185.3.camel@leckie>
	 <20140829185325.GC29456@peff.net>
	 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:18:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNScb-00019U-Pw
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 22:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbaH2USF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 16:18:05 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:63575 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbaH2USE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 16:18:04 -0400
Received: by mail-qg0-f48.google.com with SMTP id z107so2772648qgd.21
        for <git@vger.kernel.org>; Fri, 29 Aug 2014 13:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=QxFVpsG+TrV7SZD6+Bsmpe9CR3YDAA5oT4Ol3aobL8c=;
        b=PXgdGKPNQkS9zX+2Wx+kj78+2WeU5kNcGYnrnqAKD8OUaeyauTwtB34bBDhS1GcK06
         0CkAHIEvTg9OsyKAzNTarrSWK0VauM/mWv3IrkjXz4w8ATkuINQLLLP3WGiFHcpaaFZM
         8KTc8sWBLr0oEZCKXmt2rjOqtU67lUaTvPj+W6CkIuLAAUWGnZKLonAXpyTLFC0dyFhZ
         uQdtE/g9V1b4DKTZLMP/lPm07orImUocgD7UVLOWFqT6Gm143dMH5rxGdqddzYb365l1
         ZA9nQ8qRu+rLL9tMBaDoVJY256DvCot4ZjUmbdGOg04qN/LCEP5XhZLcxVqZ+CFmzot+
         ccHA==
X-Gm-Message-State: ALoCoQm69hZbgOzaqYbY07ULj1/ZKwnCy+kuhAXB4YX9SQqzHfOHNQF+gjNWVZRklaXvqW3JRJjg
X-Received: by 10.224.86.5 with SMTP id q5mr22061581qal.36.1409343482787;
        Fri, 29 Aug 2014 13:18:02 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id v1sm2907893qat.17.2014.08.29.13.18.01
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 29 Aug 2014 13:18:02 -0700 (PDT)
In-Reply-To: <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256186>

On Fri, 2014-08-29 at 12:21 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Aug 27, 2014 at 06:10:12PM -0400, David Turner wrote:
> >
> >> It looks like git fsck exits with 0 status even if there are some
> >> errors. The only case where there's a non-zero exit code is if
> >> verify_pack reports errors -- but not e.g. fsck_object_dir.
> >
> > It will also bail non-zero with _certain_ tree errors that cause git to
> > die() rather than fscking more completely.
> 
> Even if git does not die, whenever it says broken link, missing
> object, or object corrupt, we set errors_found and that variable
> affects the exit status of fsck.  What does "some errors" exactly
> mean in the original report?  Dangling objects are *not* errors and
> should not cause fsck to report an error with its exit status.

error in tree 9f50addba2b4e9e928d9c6a7056bdf71b36fba90: contains
duplicate file entries

(at least -- there might be more, but that's the one that bit me)
