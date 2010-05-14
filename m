From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Fri, 14 May 2010 12:53:42 +0200
Message-ID: <201005141253.46956.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005111551.21316.jnareb@gmail.com> <20100513131016.GA5250@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Fri May 14 12:54:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCsX3-0007uk-Rd
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 12:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab0ENKyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 06:54:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60004 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0ENKyC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 06:54:02 -0400
Received: by fxm6 with SMTP id 6so1333387fxm.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=h4p35AgX0+ye8mrTocaKegrvQMKyHmSXOh+8jjt2ScI=;
        b=wyeBdsZLrDawu6se6OPmQIG7KD4UHwittMIA8jqKLl6gMkuI+AUzONZVJ9MWfVp7Dv
         7Cu+nFNGgUuymj0Z8jpnpOMoA/rLqlerLg3SUJNJvv2Yoazhhg7uhlF59CTi6ieg+r0I
         qu7FJRY6VApQILqOMtX7AygqaBlQMGTph1zuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UxqGbCsRr1I8Og1zftqtYYb5T3+ct4nEWQn3I5sRGN7f3URModxiT6ichjFk0q0O/C
         0z4UfLS/0MygIw7tsjNI2gjlKCAHhXE/vQoPNXwmmZiNRQfv5JqsNWWKvu++Xh4BUd/G
         9iUlgF9L393SWqs1BrvLTLGLD0qUCfXFbTQNk=
Received: by 10.223.30.130 with SMTP id u2mr1383619fac.70.1273834440243;
        Fri, 14 May 2010 03:54:00 -0700 (PDT)
Received: from [192.168.1.13] (abvp84.neoplus.adsl.tpnet.pl [83.8.213.84])
        by mx.google.com with ESMTPS id y12sm10371508faj.17.2010.05.14.03.53.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 03:53:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100513131016.GA5250@screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147080>

On Thu, 13 May 2010, Peter Vereshagin wrote:
> 2010/05/11 15:51:15 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
>> On Tue, 11 May 2010, Peter Vereshagin wrote:
>>> 2010/05/11 12:58:50 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
 
>>>>>> I have changed this 'exit' to non-local goto to toplevel.  It could be
>>>>>> done instead by redefining 'exit' subroutine, like shown below, but I
>>>>>> feel that would be hacky if you can change gitweb code (it is not
>>>>>> black box you should not touch).
>>>>> 
>>>>> Right, one shouldn't ever redefine perl built-in functions. I did only because
>>>>> of no other way to 'get things working'
>>>> 
>>>> Why not?  For example CGI::Carp redefines 'die' to log errors.
>>> 
>>> Ouch, sorry, I meant 'last' or something like that.
>> 
>> "last" / "last LABEL" is a command, not a function, therefore you cannot
>> redefine it.
> 
> It's a flow control statement, thus it is a built-in thing; same way as any other
> functions are explained in a 'perldoc -f'.

`perldoc -f exit` says 'The exit() function ...', while `perldoc -f last`
says 'The "last" command is like the "break" statement in C ...'.

> Therefore it is treated by monkeys crowd as function. It's obvious for me to
> stay out here (here != maillist) yet in such an environment.

Sidenote: The 'Monkey patch' article on Wikipedia says that the
technique of adding method dirctly to class instead of subclassing was
originally called "guerilla patching", then it mutated into "gorilla
patching", and finally into "monkey patching".

> Anyway, I compare "last" here  with exit() and die() which look to user just
> like the same kind of: the flow control statements. I guess any Perl user who
> makes things like gitweb (at least as a CGI-only app) shouldn't care about
> such an internal difference of flow control statements those are
> hidden/incapsulated inside the implementation of those statements?

Perl hacker should know the difference between command such as "last"
and "next", and functions such as exit() and die().  Just like C
programmer should know the difference between "break" statement and
exit() function.

> Needless to mention that the 'last LABEL' ( goto, gosub, ... named them )  is a
> bad and a very deprecated style which is every schoolboy is aware about
> nowadays to keep from using in the application [...]

Not true.  The 'last LABEL;' command is very useful to exit nested
loops.  If used right it makes code much simpler (allowing to avoid
extra flag variable and/or complicating loop conditional).  If I
remember correctly in O.-J. Dahl, Edsger W. Dijkstra, C. A. R. Hoare
"Structured Programming" the programming language described includes
"break <n>" statement, with similar purpose as "last LABEL" in Perl.

Note also that Dijkstra wrote in seminal article "Go To Statement
Considered Harmful" that the problem with abused 'goto' is that it
compilcates and muddles control flow of program.  But there are
legitimate uses of 'goto' that make the program simpler to understand,
and not harder,... among those is handling exceptions.

>>>> I know this from painful experience of trying to find bug in a
>>>> test... when the error was in parsing file in 'do $file;'.
>>> 
>>> I handle them just fine like in any other CGI program using
>>> CGI::Carp:fatalsToBrowser. Are you about to 'make test' via the http? ;-)
>> 
>> I don't think you understand what I wanted to say there.
>> 
>> If you don't check if there were parse errors from 'do $file;', you can
>> get later some error message which is totally unrelated to the parsing
>> error.  If you don't know or forget that you should check $@ after 
>> 'do $file;', and are unlucky, you can chase elusive error from there
>> to kingdom come...
> 
> Got it, it's about the inclusion failure via the do() which is the
> development, not a production, situation.

Yes, it is a problem mainly in developemtn, where changes to the file
included via "do <file>" might introduce parsing errors.

> I think this should be an adjective noun to use the both strict and
> the warnings?

The problem is that "do <file>;" is similar to "eval `cat <file>`;"
(except that it's more efficient and concise), it that it silences
parsing errors.  From `perldoc -f do`:

  If "do" cannot read the file, it returns undef and sets $! to the error.
  If "do" can read the file but cannot compile it, it returns undef and sets
  an error message in $@.   If the file is successfully compiled, "do"
  returns the value of the last expression evaluated.

> And yes, since it's about development but not production use, die is just fine
> in the inclusion code like this:
> 
> eval( 'use Module;' ); die $@ if $@;

Wrong!
 
> as always, require() can do the trick, not to mention usual 
> 
> use Module;
> 
> This all will cause die() when it's necessary as only the application developer
> knows how strict is the dependence on the Module. In some cases, application
> can work without some Module but it's just better with it.

First, both "use Module;" and "require Module;" (and "require '<file>';")
do automatic error checking and raise an exception if there is problem.

Second, "use Module <LIST>;" is equivalent to

  BEGIN { require Module; import Module <LIST>; }

and therefore it doesn't make sense to use it for conditional inclusion.


Therefore, to load Perl module / file, if you can 'die' you can simply
use

  require "<file>";

If you don't want to die, but want to know if loading and parsing file
succeeded or not, you should use the following syntax:

  if (eval { require "<file>"; 1 }) {
    ...
  } else {
    ...
  }

If you want to use 'do "<file>";' (it is preferred in some
circumstances), you really should check for error conditins:

  unless (my $return = do "<file>") {
    if ($@) {
       # couldn't parse <file>
    } elsif (!defined $return) {
       # couldn't do <file> (e.g. couldn't find <file>)
    }
    ...
  }

[...]
>> PSGI is interface, Plack is reference implementation.  You can run PSGI
>> app on any supported web server; this includes running PSGI apps on
>> FastCGI.
> 
> Existing problem FCGI::Spawn for is not the PSGI applications to be run as a
> FastCGI, but the bunch of existing CGI.pm applications (even gitorious) need
> to be more effective with the widest-spread protocol FastCGI. Best without any
> patching of the application, deployed the same simple way as with apache's cgi
> implementation.

Gitorious is in Ruby, therefore is not a CGI.pm application, as it is
not even in Perl.

By using Plack::App::CGIBin you can load CGI scripts from a directory
and convert them into a <persistent> PSGI application.  You can use
Plack::App::WrapCGI to convert single CGI script into PSGI application.
You can use Plack::Buuilder's domain specific language to join (map)
together a bunch of PSGI applications (in different paths) in a single
app (via Plack::App::URLMap).

You can then run PSGI application (for example the PSGI app which loads
CGI apps via Plack::App::CGIBin) on any supported web server, which
includes FCGI (FastCGI).

-- 
Jakub Narebski
Poland
