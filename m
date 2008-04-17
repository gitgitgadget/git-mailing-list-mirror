From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 04:46:45 +0400
Message-ID: <20080417004645.GK3133@dpotapov.dyndns.org>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com> <20080416200107.GG3133@dpotapov.dyndns.org> <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com> <20080416203923.GH3133@dpotapov.dyndns.org> <320075ff0804161447u25dfbb2bmcd36ea507224d835@mail.gmail.com> <20080416223739.GJ3133@dpotapov.dyndns.org> <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 02:47:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmIHr-0003Et-T1
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 02:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbYDQAqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 20:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbYDQAqx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 20:46:53 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:44612 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbYDQAqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 20:46:52 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3068037fkr.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=9t49DlLylesWFWQ7vhEi0vNJ27CxoPWTMbSyy+Ykrzk=;
        b=OWsP9fTz+Qh+A9A0eT17ZfJ/9p6b6ttL9PgQlFmQsF2IxfdH24Zf2Avx5k3b4kGQ+hiXm4PjsXdNI7uJAf38dtuDTnQRSN7RLIxPTC+53Ywmo8iKXDspjnOPWPyjTQROSeaLhsHqUqERwYZZVNYIlff4+jCuv5R4uphrY/0UCKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=cxkNZr6ki1Bjfl4UWlMOaKFVIJtmUH/RB7h4kXPdXk0BnC7Jho5tbgSgAkdmGs8k32S2V7XQqjhGa/rbf6zQXpTXbgM1JaQ19Uc7y6fHApWcNGOrBQw/pwjTe0K+kKIND4FwxHLi/4ieCAwA0mKcrBNpI51WPBi0jryEBehy0UE=
Received: by 10.82.123.8 with SMTP id v8mr1107064buc.30.1208393210358;
        Wed, 16 Apr 2008 17:46:50 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id g17sm14585458nfd.10.2008.04.16.17.46.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 17:46:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79763>

On Thu, Apr 17, 2008 at 12:07:27AM +0100, Nigel Magnay wrote:
> >  > The bit I really don't understand is why git thinks a file that has
> >  > just been touched has chnaged when it hasn't,
> >
> >  Actually, it did change in the sense that if you try to commit this
> >  file now into the repository, you will have a different file in Git!
> >  So, it is more correct to say that Git did not notice this change until
> >  you touch this file, because this change is indirect (autocrlf causes
> >  a different interpretation of the file).
> >
> 
> Okay - at the very least this behaviour is really, really confusing.
> And I think there's actually a bug (it should *always* report that the
> file is different), not magically after it's been touched.

I don't think there is a simple way to correct that without penalizing
normal use cases. Usually, people do not change autocrlf during their
normal work. Besides, you can have your own input filters and they may
cause the same effect. So, Git works in the assumption that input filters
always produce the same results...

> 
> But fixing that minor bug still leads to badness for the user. Doing
> (on a core.autocrlf=true machine) a checkout of any revision
> containing a file that is (currently) CRLF in the repository, and your
> WC is *immediately* dirty. However technically correct that is, it
> doesn't fit most people's user model of an SCM, because they haven't
> made any modification.

IMHO, the only sane way is never store CRLF in the Git repository.
You can have whatever ending you like in your work tree, but inside
of Git, LF is the actually marker of the end-of-line.

> And if 1 person makes a change along with their
> conversion, and the other 'just' does a CRLF->LF conversion,

If you imported correctly in Git, it should not have CRLF for text
files. So, there is no conversion that a user does expliciltly.

> And because the svn is
> mastered crlf (well, strictly speaking, it's ignorant of line endings)
> this is gonna happen a lot.

Not really. SVN has its own setting for EOL conversion. If you have
'svn:eol-style' set to 'native' for any text file then SVN will
checkout text files accordingly to your native EOL (you can specify
your native EOL using the --native-eol option when it is necessary).

> Can't git be taught that if the WC is byte-identical to the revision
> in the repository (regardless of autocrlf) then that ought not to be
> regarded as a change?

Why should not it? If a file is different as long as Git repository is
concern then then it *is* a change. Git binary compare files _after_
applying all specified filters (and you can have your own filters, not
only autocrlf).

> Is there a way I can persuade the diff / merge mechanisms to normalise
> before they operate? (e.g if core.autocrlf does lf->crlf/crlf->lf,
> then an equivalent that does crlf->lf/crlf->lf before doing the merge
> )?

I am not sure if there is a standard option for that, but it is
certainly possible to define your own merge strategy.

> 
> In a perfect world I'd be able to switch all files int he repo to LF,
> but that's not going to happen any time soon because of the majority
> of developers, still on svn, still on windows.

Well, I don't see any problem here if everything is configured properly.
How files are stored inside and what you have in your work tree does
not have to be the same. So, storing everything inside with LF is
certainly possible. Actually, I believe it is exactly what CVS does
(unless you added a file with '-kb'), and people use CVS on Windows.
Importing files with CRLF in Git, it is like putting files as _binary_
in CVS.

Dmitry
