From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH 01/10] Add a parseopt mode to git-rev-parse to bring
	parse-options to shell scripts.
Date: Sun, 4 Nov 2007 12:29:31 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071104112931.GB2119@ins.uni-bonn.de>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org> <1194172262-1563-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:29:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iodfq-0005MD-AU
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637AbXKDL3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755869AbXKDL3e
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:29:34 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:43541 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136AbXKDL3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 06:29:34 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id B84B5400004AE;
	Sun,  4 Nov 2007 12:29:32 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1194172262-1563-2-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63382>

Hello Pierre,

A couple of language nits:

* Pierre Habouzit wrote on Sun, Nov 04, 2007 at 11:30:53AM CET:
> +PARSEOPT
> +--------
> +
> +In `--parseopt` mode, `git-rev-parse` helps massaging options to bring to shell
> +scripts the same facilities C builtins have. It works as an option normalizer
> +(e.g. splits single switches aggregate values), a bit like `getopt(1)` does.
> +
> +It takes on the standard input the specification of the options to parse and
> +understand, and echoes on the standard ouput a line suitable for `sh(1)` `eval`
> +to replace the arguments with normalized ones.  In case of error, it ouputs

s/ouputs/outputs/

> +usage on the standard error stream, and exits with code 129.
> +
> +Input Format
> +~~~~~~~~~~~~
> +
> +`git-ref-parse --parseopt` input format is fully text based. It has two parts,

s/^/The /
s/git-ref-parse/git-rev-parse/

> +separated by a line that contains only `--`. The lines before (should be more
> +than one) are used for the usage. The lines after describe the options.

I would write
  s/before/& the `--`/
  s/after/& the `--`/

or maybe write "separator" instead of `--`.

[...]
> +`<opt_spec>`::
> +	its format is the short option character, then the long option name
> +        separated by a comma. Both parts are not required, though at least one
> +        is necessary. `h,help`, `dry-run` and `f` are all three correct
> +        `<opt_spec>`.
> +
> +`<arg_spec>`::
> +	an `<arg_spec>` tells the option parser if the option has an argument
> +        (`=`), an optionnal one (`?` though its use is discouraged) or none

s/optionnal/optional/

> +        (no `<arg_spec>` in that case).
> +
> +The rest of the line after as many spaces up to the ending line feed is used
> +as the help associated to the option.

I'd write (in case that is technically correct):
  After following white space, the rest of the line after is used as the
  help associated to the option.

> +Blank lines are ignored, and lines that don't match this specification are used
> +as option group headers (start the line with a space to purposely create such
> +lines).

I'd write:
  ... to create such lines on purpose.

> +Example
> +~~~~~~~
> +
> +------------
> +OPTS_SPEC="\
> +some-command [options] <args>...
> +
> +some-command does foo and bar !

Please no white space before "!".

> +--
> +h,help    show the help
> +
> +foo       some nifty option --foo
> +bar=      some cool option --bar with an argument
> +
> +  An option group Header
> +C?        option C with an optionnal argument"

s/optionnal/optional/

Cheers,
Ralf
