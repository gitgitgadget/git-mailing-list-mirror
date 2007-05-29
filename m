From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (tig)] Infrastructure for tig rpm builds.
Date: Wed, 30 May 2007 01:31:16 +0200
Message-ID: <200705300131.17137.jnareb@gmail.com>
References: <200705281054.05376.jnareb@gmail.com> <20070529202923.GA6358@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed May 30 01:26:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtB5a-0007k5-6Y
	for gcvg-git@gmane.org; Wed, 30 May 2007 01:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbXE2X0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 19:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbXE2X0N
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 19:26:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:24041 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbXE2X0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 19:26:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so51909ugf
        for <git@vger.kernel.org>; Tue, 29 May 2007 16:26:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=m0K0htUkcSnB9UAErycaSM35nk62ywiksCXqk6PToxzZaMwQ8KGYht6n1ENxRBtCiZYcbs8PTSiHPRQ41jRF1M5fQTPnOTjY73NIe1MLQS+AgtpjIVkpcANSYbw0lPmImNnpb3hIXQtYrNO+9Qw5Fq8qsxFZVWkVy5zd9E1WUVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VMn+LJNc/svLpUbgHvvOVXuQ8W3wR9UjsufGsQJ1wqPL7zF1tG8Hekcnz4FpGYIdLQ7J8qOdLg4IMd/csvheis1HGfgrpP6pRYAPnK/0xUu/yS/ksc6X559DP86WsU6svK96V+fRzsRWP5aMmKozorOrNBqACGw5RPV8rgfprBw=
Received: by 10.67.30.6 with SMTP id h6mr132535ugj.1180481170475;
        Tue, 29 May 2007 16:26:10 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id i5sm33154893mue.2007.05.29.16.26.07;
        Tue, 29 May 2007 16:26:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070529202923.GA6358@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48712>

On Tue, 29 May 2007, Jonas Fonseca wrote:
> Jakub Narebski <jnareb@gmail.com> wrote Mon, May 28, 2007:

>> Minimally tested (meaning "make rpm" from tig repository works).
> 
> Trying 'make rpm' on ubuntu 7.04 I get:
> 
>   $ rpmbuild -ta tig-0.6.g2463b4e.tar.gz
>   error: Name field must be present in package: (main package)
>   error: Version field must be present in package: (main package)
>   error: Release field must be present in package: (main package)
>   error: Summary field must be present in package: (main package)
>   error: Group field must be present in package: (main package)
>   error: License field must be present in package: (main package)
>   $ ls -l /usr/src/rpm/SPECS/
>   total 0
>   -rw------- 1 root root 0 2007-05-29 21:46 tar: Pattern matching characters used in file names. Please,
> 
> Strange.

Hmmm... WORKSFORME. Aurox 11.1 (Fedora Core 4 based distribution),
with rpm 4.4.1. By the way, isn't Ubuntu based on Debian? Do you
have rpmbuild installed?

BTW. perhaps you could provide spec equivalent for building tig*.deb?

  1000:[master!tig]$ make rpm
  sed -e 's/@@VERSION@@/0.6.5.g2bba6eb/g' < tig.spec.in > tig.spec+
  mv tig.spec+ tig.spec
  git-archive --format=tar \
  --prefix=tig-0.6.5.g2bba6eb/ HEAD^{tree} > tig-0.6.5.g2bba6eb.tar
  tar rf tig-0.6.5.g2bba6eb.tar \
         tig-0.6.5.g2bba6eb/tig.spec \
         tig-0.6.5.g2bba6eb/version
  gzip -f -9 tig-0.6.5.g2bba6eb.tar
  rpmbuild -ta tig-0.6.5.g2bba6eb.tar.gz
  Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.85822
  + umask 022
  + cd /home/local/builddir/BUILD
  + LANG=C
  + export LANG
  + unset DISPLAY
  + cd /home/local/builddir/BUILD
  + rm -rf tig-0.6.5.g2bba6eb
  + /usr/bin/gzip -dc /home/jnareb/tig/tig-0.6.5.g2bba6eb.tar.gz
  + tar -xf -
  + STATUS=0
 
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> ---
>> 'tig.spec.in' is based on 'git.spec.in' from git repository.
>> 
>> This is the initial, minimal version.  For example it does not add
>> TIG-VERSION-GEN file and the rest of versioning infrastructure that is
>> used in git Makefile.
> 
> I would prefer to do without. ;)

I think we can do without it, but in current implementation there is
no guarantee that we would not get wrong version.
 
[...]
>> P.S. I have build tig-0.6.4.g9eded37-1.i386.rpm using "make rpm" from
>> tig repository, and installed it without problems, but when trying to
>> build it again _without network_ it failed on building
>> manual.pdf. Error log attached.
> 
> Looks like some problems with the SGML catalogs info.

If I only knew how to debug that...

>> I think we can skip generation of manual.pdf, and generate it only on
>> request (e.g. "make doc-pdf"), or using doc-man and doc-html in place
>> of doc in the spec file... but this is better left for the next
>> commit.
> 
> Good idea, PDF is not essential and probably suboptimal to either of the
> HTML versions of the manual.

And it is very easy to implement: just replace 'doc' in make invocation
in tig.spec.in by the 'doc-man doc-html'.

>> By the way, why do you use xmlto and docbook2pdf, instead of a2x from
>> asciidoc package?
> 
> It is a fairly recent addition to the asciidoc. Besides, I just tried it
> and it seems to be completely unusable on ubuntu because of the way it
> has been packaged; it cannot find required files.

Fair enough.
 
[...]
>> diff --git a/Makefile b/Makefile
>> index 06a5d6a..45c833b 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -18,8 +18,16 @@ DOCS	= $(DOCS_MAN) $(DOCS_HTML) \
>>  ifneq (,$(wildcard .git))
>>  VERSION = $(shell git-describe)
>>  WTDIRTY = $(shell git-diff-index --name-only HEAD 2>/dev/null)
>> -CFLAGS += '-DVERSION="$(VERSION)$(if $(WTDIRTY),-dirty)"'
>> +else
>> +GEN_VER="tig-0.6.TIG"
>> +VERSION = $(shell test -f version && cat version || echo "$(GEN_VER)")
>>  endif
>> +CFLAGS += '-DVERSION="$(VERSION)$(if $(WTDIRTY),-dirty)"'
>> +RPM_VERSION  = $(subst tig-,,$(VERSION))
>> +RPM_VERSION := $(subst -,.,$(RPM_VERSION))
> 
> I will probably try to simplify and clean this up a bit. 

That would be nice.

[...]
>> +dist: tig.spec
>> +	git-archive --format=tar \
>> +		--prefix=$(TARNAME)/ HEAD^{tree}> $(TARNAME).tar
>> +	@mkdir -p $(TARNAME)
>> +	@cp tig.spec $(TARNAME)
>> +	@echo $(VERSION)> $(TARNAME)/version
>> +	tar rf $(TARNAME).tar \
>> +	       $(TARNAME)/tig.spec \
>> +	       $(TARNAME)/version
>> +	@rm -rf $(TARNAME)
>> +	gzip -f -9 $(TARNAME).tar
> 
> Does the .spec file need to be in the tarball for rpm to work? I mean,
> if it can be generated from .spec.in, I would rather have the rpm target
> create it?

Having .spec file in the tarbal allows to download tarball and use
'rpmbuild -ta tig-*.tar.gz' to build rpms; no need to unpack then do
'make rpm'.

Besides rpm target makes use of this, although there is alternate
solution.

>> +rpm: dist
>> +	rpmbuild -ta $(TARNAME).tar.gz

[...]
>> +BuildRequires: 	ncurses-devel%{!?_without_docs:, xmlto, asciidoc> 6.0.3, /usr/bin/docbook2pdf}
> 
> Is the last entry a shorthand for the doc dependencies you listed above?

Nope, the list of packages was because the error with creating
manual.pdf might depend on versions of packages I have installed.

The last entry written using name of binary (needed to generate
manual.pdf) because I think where this tool can be found, i.e.
in which package, might depend on distribution you use. For example
in FC4 it is in docbook-utils-pdf package.

[...]
>> +%files
>> +%defattr(-,root,root)
>> +%{_bindir}/*
>> +%doc README COPYING INSTALL SITES BUGS TODO tigrc

By the way, should we put tigrc in examples/tigrc, or perhaps in some
skeleton file?

> I don't know if manual.txt should perhaps be included if
> HTML and PDF files will not be generated.
> 
>> +%{!?_without_docs: %{_mandir}/man1/*.1*}
>> +%{!?_without_docs: %{_mandir}/man5/*.5*}
>> +%{!?_without_docs: %doc *.html *.pdf}

O.K. It would be as easy as %{?_without_docs: %doc *.txt}

-- 
Jakub Narebski
Poland
