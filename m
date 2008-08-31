From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 22:23:36 +0200
Message-ID: <200808312223.38222.jnareb@gmail.com>
References: <20080830173947.GF7185@schiele.dyndns.org> <7v63ph40at.fsf@gitster.siamese.dyndns.org> <32541b130808311129u79f4179enfabab8f5845ed522@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	"Jeff King" <peff@peff.net>, "Robert Schiele" <rschiele@gmail.com>,
	git@vger.kernel.org, "Lea Wiemann" <lewiemann@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Petr Baudis <pasky@suse.cz>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 22:24:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZtTg-00070s-5K
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 22:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976AbYHaUXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 16:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757224AbYHaUXm
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 16:23:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:42628 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756944AbYHaUXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 16:23:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1099477fgg.17
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5OoXOEFX+WSyeFDZCxwUZl8svu5aMmUxjqp9APeoTI4=;
        b=K2jrzOMt6ob0F034jL0iYneVkcVzjfKiXXWvfl+SmuOfv8YgjeFXaDBnxc/3e18VQ6
         M2odM4nH2wLkskVm6YtW8ZRFXwDoyZKjSVTlX1mdskN3MQe7j1cIAlJcLy0EN0PAEwGf
         QUh16ObU3JfinGpgGWUyLNKYrY6JqKAD+SqGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JoHaqzT4/f8XZ7n5F6YWNArLdfQNPmZ5QtdcBHFwF++WNRx5XhZpqZriRz2ZX1Hza7
         OJ8dBzlJE2p37razkMqgM7/ZvjCiP86wgLsMBC4ezWTRYlOrLdnjF8Fwjp5kDaLNAtWn
         JtN7IuOHaFEOYVPvKrM3W400W78ZcTanUaDr4=
Received: by 10.103.192.2 with SMTP id u2mr3747527mup.45.1220214219743;
        Sun, 31 Aug 2008 13:23:39 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.20])
        by mx.google.com with ESMTPS id u26sm8023187mug.5.2008.08.31.13.23.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Aug 2008 13:23:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <32541b130808311129u79f4179enfabab8f5845ed522@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94506>

On Sub, 31 August 2008, Avery Pennarun wrote:
> On Sun, Aug 31, 2008 at 12:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>>
>>>>>>>> "Avery" == Avery Pennarun <apenwarr@gmail.com> writes:
>>>
>>> Avery> Shell quoting is a disaster (including security holes, where relevant)
>>> Avery> waiting to happen.  The above is the only sane way to do it, and it
>>> Avery> isn't very hard to implement.  (Instead of system() in the subprocess,
>>> Avery> you can use exec().)
>>>
>>> quotemeta() is about regex quoting.  This is not precisely the same as shell
>>> quoting, and is both misleading, and potentially broken.
>>
>> Agreed to, and grateful for, both of your comments.
>>
>> Do you like the one Jakub quoted from how gitweb does it?  It looks like
>> this:
>>
>>    # quote the given arguments for passing them to the shell
>>    # quote_command("command", "arg 1", "arg with ' and ! characters")
>>    # => "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
>>    # Try to avoid using this function wherever possible.
>>    sub quote_command {
>>           return join(' ',
>>                       map( { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ ));
>>    }
> 
> No, that's just another feeble attempt at quoting, which may or may
> not be correct.  I'm not smart enough to tell.

First, according to POSIX, for POSIX-compatibile shells we should have:

 2. Shell Command Language
 2.2 Quoting
 2.2.2 Single-Quotes

 Enclosing characters in single-quotes ( '' ) shall preserve the literal
 value of each character within the single-quotes. A single-quote cannot
 occur within single-quotes.

http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_02_02

So that is why single quote "'" must be escaped as "I'am" -> 'I'\''am'
(' -> '\'', i.e. close quote, escaped ' = \', (re-)open quote).


Second, as Lea Wrote in commit message for 516381d5:

    gitweb: quote commands properly when calling the shell
    
    This eliminates the function git_cmd_str, which was used for composing
    command lines, and adds a quote_command function, which quotes all of
    its arguments (as in quote.c).

We have to go to quote.c to get to know why "!" is a special case too,
in addition to "'".  The commit message for 77d604c3 (by H. Peter Anvin,
which is CC-ed) states:

    Create function to sq_quote into a buffer
    Handle !'s for csh-based shells

> I have a proper implementation in the 'runlock' script in gitbuilder:
> 
>     http://github.com/apenwarr/gitbuilder/tree/master/runlock
> 
> In that particular case, I wanted to handle signals carefully, so I
> needed the manual fork thing even in perl 5.8.  You can safely remove
> the signal handling stuff (and of course the lockfile stuff) if you
> just want a minimal safe fork-exec-wait implementation in perl.

But if we go this way, i.e. fork+exec (perhaps implicit fork), why do
not simply use appropriate commands from Git.pm (Git::Repo doesn't
have it yet, IIRC).  As far as I remember Git.pm was created initially
to unify all different "safe_pipe" and "safe_cmd" implementations among
different Perl scripts in Git (Petr "Pasky" Baudis CC-ed).

-- 
Jakub Narebski
Poland
